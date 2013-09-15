require 'bootstrap_pagination_helper'

class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  layout 'categories_products_layout'
  
  def index
    @cart = current_cart
    @popular_products = ProductRecommendationFactor.where(:user_id => current_user.id).order("factor DESC").limit(10)
    @max_factor = @popular_products.first.factor unless @popular_products.blank?
  end

  def show
    @category = Category.find_by_id(params[:id])
    @products = @category.products.order(:name).paginate(:page => params[:page], :per_page => 15)
    @cart = current_cart
  end
end