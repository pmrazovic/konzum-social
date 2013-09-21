class ProductsController < ApplicationController
  before_filter :authenticate_user!
  layout 'categories_products_layout'

  def show
    @product = Product.find_by_id(params[:id])
    @like = current_user.likes.where(:likeable_id => @product.id, :likeable_type => 'PRODUCT').first
    @favorite = current_user.favorites.where(:product_id => @product.id).first
    @cart = current_cart
    @popular_products_in_category = ProductRecommendationFactor.where(:user => current_user, :product_id => @product.leaf_category.parent.products - [@product]).order("factor DESC").limit(5)
    @max_factor = @popular_products_in_category.first.factor unless @popular_products_in_category.blank?
  end

  def share
    @product = Product.find_by_id(params[:id])
    graph = Koala::Facebook::API.new(current_user.facebook_authentication.token)
    options = {
      :message => "Check out this product on Konzum Online Store",
      :name => "#{@product.name}",
      :link => "#{product_url(@product)}",
      :caption => "#{@product.manufacturer}",
      :description => "Price: #{ActionController::Base.helpers.number_to_currency(@product.price, :unit => 'HRK ', :separator => ',', :delimiter => '.')}",
      :picture => "http://online.konzum.hr/images/products/030/03063431l.gif"
    }
    graph.put_object("me", "feed", options)
    redirect_to :back
  end
end