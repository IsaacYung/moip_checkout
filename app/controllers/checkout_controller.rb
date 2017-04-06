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
      total_discount = total_price*(coupon.discount.to_f/100)
      total_discount = total_discount.to_i
    end

    checkout = Checkout.new
    order_response = checkout.create_order(order, customer, total_discount, total_price)
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

    payment.update(instalment_count: payment_params[:instalment_count], funding_instrument: "CREDIT_CARD")

    checkout = Checkout.new
    payment_response = checkout.create_payment(order, payment_params)

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

  def payment_params
    params.require(:payment).permit(:card_number, :holder_name, :cvc, :expiration_month, :expiration_year, :holder_birthdate, :cpf, :phone, :instalment_count, :order)
  end

  def customer_params
    params.require(:customer).permit(:fullname, :email, :phone, :birth_date, :tax_document)
  end
end
