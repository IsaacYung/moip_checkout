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
    customer = Customer.new(customer_params);
    customer.save
  end

  def payment
  end

  def confirm
  end

  def customer_params
    params.require(:customer).permit(:fullname, :email, :phone, :birth_date, :tax_document)
  end
end
