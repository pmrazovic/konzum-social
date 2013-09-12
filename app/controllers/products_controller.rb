class ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout 'categories_products_layout'

  def show
    @product = Product.find_by_id(params[:id])
    @like = current_user.likes.where(:likeable_id => @product.id, :likeable_type => 'PRODUCT').first
    @favorite = current_user.favorites.where(:product_id => @product.id).first
    @cart = current_cart
  end
end