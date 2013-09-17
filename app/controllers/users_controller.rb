require 'bootstrap_pagination_helper'
require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @cart = current_cart
    @user = User.find_by_id(params[:id])
    @user_activities = UserActivity.where(:user_id => @user.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
  end

  def profile_orders
    @cart = current_cart
    @user = User.find_by_id(params[:id])
    @orders = @user.orders.order('created_at DESC').paginate(:page => params[:page], :per_page => 15)
  end

  def profile_likes
    @cart = current_cart
    @user = User.find_by_id(params[:id])
    @likes = @user.likes.paginate(:page => params[:page], :per_page => 15)
  end

  def profile_favorites
    @cart = current_cart
    @user = User.find_by_id(params[:id])
    @favorites = @user.favorites.paginate(:page => params[:page], :per_page => 15)
  end

  def profile_recipes
    @cart = current_cart    
    @user = User.find_by_id(params[:id])
    @recipes = @user.recipes
  end  

end