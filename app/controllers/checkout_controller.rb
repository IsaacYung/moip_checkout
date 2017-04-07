class CheckoutController < ApplicationController
  def customer
    products = cookies[:cart]
    product_movements = JSON.parse products
    product_ids ||= []
    product_movements.each do |item|
      product_ids << item['product_id']
    end

    @coupons = Coupon.all
    @products = Product.find(product_ids)
  end

  def customer_new
    products_cart = cookies[:cart]
    product_movements = JSON.parse products_cart

    customer = Customer.new(customer_params);
    customer.save

    order = customer.orders.create()

    total_price = 0
    product_movements.each do |item|
      product = Product.find(item['product_id'])
      order.product_movements.create(product_id: item['product_id'], quantity: item['quantity'], status: "SUSPENDED")
      product.update(quantity: product.quantity - item['quantity'])
      total_price += product.price
    end

    if coupon = Coupon.where(code: params[:coupon]).first
      total_discount = handle_value coupon.discount, total_price
    end

    checkout = Checkout.new
    order_response = checkout.create_order(order, customer, total_discount)
    order.update(external_id: order_response.id)
    customer.update(external_id: order_response.customer.id)

    redirect_to checkout_payment_path(order.id)
  end

  def payment
    checkout = Checkout.new
    @order = Order.find(params[:order])
    @order_response = checkout.show_order(@order.external_id)
    payment = Payment.new(order_id: params[:order], status: "ORDERED", amount: @order_response.amount)
    payment.save
  end

  def payment_new
    order = Order.find(payment_params[:order])
    payment = Payment.where(order_id: payment_params[:order]).first
    customer = Customer.find(order.customer_id)

    payment.update(instalment_count: payment_params[:instalment_count], funding_instrument: "CREDIT_CARD")

    checkout = Checkout.new

    if payment_params[:instalment_count].to_i > 1
      payment.amount['subtotals']['addition'] = handle_value Payment::INSTALMENT_TAX, payment.amount['total']
      payment.amount['total'] = payment.amount['total'] + payment.amount['subtotals']['addition']

      order_response = checkout.create_order(order, customer, payment.amount['subtotals']['discount'], payment.amount['subtotals']['addition'])
      order.update(external_id: order_response.id)
      payment_response = checkout.create_payment(order, payment_params)
    else
      payment_response = checkout.create_payment(order, payment_params)
    end

    if payment.update(external_id: payment_response.id, status: payment_response.status)
      redirect_to checkout_confirm_path(payment.id)
    end
  end

  def confirm
    @payment = Payment.find(params[:payment_id])
    order = Order.find(@payment.order_id)

    product_ids ||= []
    order.product_movements.each do |order|
      product_ids << order.product_id
    end

    @order = order
    @customer = Customer.find(order.customer_id)
    @product = Product.find(product_ids)
  end

  def update_confirm
    resources = params[:resource];

    if resources[:payment][:id]
      payment = Payment.where(external_id: resources[:payment][:id])
    end

    payment.update(status: resources[:payment][:status])
  end

  def handle_value(handle, total)
    ((handle * (total.to_f/100))*100).to_i
  end

  def payment_params
    params.require(:payment).permit(:card_number, :holder_name, :cvc, :expiration_month, :expiration_year, :holder_birthdate, :cpf, :phone, :instalment_count, :order)
  end

  def customer_params
    params.require(:customer).permit(:fullname, :email, :phone, :birth_date, :tax_document)
  end
end
