require 'publisher'

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

  def share_on_facebook
    if current_user.connected_with_facebook?
      @product = Product.find_by_id(params[:id])
      Publisher.share(@product, product_url(@product), current_user, 'Check out this product on Konzum Online Store')
    end
    flash[:share_notice_success] = "Product was successfuly published on your timeline."
    redirect_to :back
  end

  def share_in_email
    @product = Product.find_by_id(params[:id])
    email = params[:email]
    if ApplicationHelper.is_email?(email)
      ProductRecommender.recommend(email, @product, current_user).deliver!
     flash[:share_notice_success] = "Product was successfuly sent to #{email}."
    else
      flash[:share_notice_error] = "E-mail address is not valid."
    end
    redirect_to :back
  end
end