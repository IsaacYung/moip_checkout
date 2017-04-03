class CheckoutController < ApplicationController
  def custumer
    products = cookies[:cart]
    product_movements = JSON.parse products
    product_ids ||= []
    product_movements.each do |item|
      product_ids << item['product_id']
    end

    @products = Product.find(product_ids)
  end

  def payment
  end

  def confirm
  end
end
