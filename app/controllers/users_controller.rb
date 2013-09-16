require 'bootstrap_pagination_helper'
require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @cart = current_cart
    @user = User.find_by_id(params[:id])
    @other_users = User.where.not(id: current_user).paginate(page:  params[:page], per_page: 15, order: 'last_name')
    @user_activities = UserActivity.where(:user_id => @user.id).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
  end

end