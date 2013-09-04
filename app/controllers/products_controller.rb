class ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout 'categories_products_layout'

  def show
    @product = Product.find_by_id(params[:id])
    @cart = current_cart
  end
end