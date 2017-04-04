class CheckoutController < ApplicationController
  def customer
    products = cookies[:cart]
    product_movements = JSON.parse products
    product_ids ||= []
    product_movements.each do |item|
      product_ids << item['product_id']
    end

    @products = Product.find(product_ids)
  end

  def customer_new
    products_cart = cookies[:cart]
    product_movements = JSON.parse products_cart

    customer = Customer.new(customer_params);
    customer.save

    order = customer.orders.create()

    product_movements.each do |item|
      product = Product.find(item['product_id'])
      order.product_movements.create(product_id: item['product_id'], quantity: item['quantity'], status: "SUSPENDED")
      product.update(quantity: product.quantity - item['quantity'])
    end

    checkout = Checkout.new
    order_response = checkout.create_order(order, customer)
    order.update(external_id: order_response.id)
    customer.update(external_id: order_response.customer.id)

    redirect_to :controller=>'checkout',:action=>'payment', order: order.id
  end

  def payment
    checkout = Checkout.new
    @order = Order.find(params[:order])
    @order_response = checkout.show_order(@order.external_id)
    payment = Payment.new(order_id: params[:order], status: "ORDERED", amount: @order_response.amount)
    payment.save
  end

  def payment_new
    order = Order.find(params[:order])
    payment = Payment.where(order_id: params[:order])

    payment.update(instalment_count: payment_params[:instalment_count], funding_instrument: "CREDIT_CARD")

    checkout = Checkout.new
    payment_response = checkout.create_payment(order, payment_params)

    payment.update(external_id: payment_response.id, status: payment_response.status)
  end

  def confirm
  end

  def payment_params
    params.require(:payment).permit(:card_number, :holder_name, :cvc, :expiration_month, :expiration_year, :holder_birthdate, :cpf, :phone, :instalment_count, :order_id)
  end

  def customer_params
    params.require(:customer).permit(:fullname, :email, :phone, :birth_date, :tax_document)
  end
end
