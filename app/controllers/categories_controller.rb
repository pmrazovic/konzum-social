require 'bootstrap_pagination_helper'

class CategoriesController < ApplicationController
  before_filter :authenticate_user!
  layout 'categories_products_layout'
  
  def index
  end

  def show
    @category = Category.find_by_id(params[:id])
    @products = @category.products.order(:name).paginate(:page => params[:page], :per_page => 15)
  end
end