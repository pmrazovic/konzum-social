require 'bootstrap_pagination_helper'

class DashboardController < ApplicationController
  before_filter :check_for_authentication, :only => [:index]

  def index
    @cart = current_cart
  end

  def orders
    @cart = current_cart
    @orders = current_user.orders.order("created_at DESC").paginate(:page => params[:page], :per_page => 15)

  end

  def friends
    @cart = current_cart
    @friends = current_user.friends.order(:last_name).paginate(:page => params[:page], :per_page => 10)
  end

  def liked_products
    @cart = current_cart
    @likes = current_user.likes.paginate(:page => params[:page], :per_page => 15)
  end

  def favorite_products
    @cart = current_cart
    @favorites = current_user.favorites.paginate(:page => params[:page], :per_page => 15)
  end

  def recipes
    @cart = current_cart    
    @recipes = current_user.recipes
  end

  def shopping_lists
    @cart = current_cart
  end

  def check_for_authentication
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end