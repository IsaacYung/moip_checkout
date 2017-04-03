class CatalogController < ApplicationController
  def index
    @products = Product.all
  end

  def movement
    cookies[:cart] = cart_params

    redirect_to :controller => 'posts', :action => 'show'
  end

  def cart_params
     params.require(:cart).permit(:products)
  end
end
