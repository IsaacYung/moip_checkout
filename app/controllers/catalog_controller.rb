class CatalogController < ApplicationController
  def index
    @products = Product.all
  end

  def movement
    cookies[:cart] = cart_params.values

    redirect_to :controller => 'checkout', :action => 'custumer'
  end

  def cart_params
     params.require(:cart).permit(:products)
  end
end
