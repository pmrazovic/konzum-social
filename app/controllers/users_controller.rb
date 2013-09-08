require 'bootstrap_pagination_helper'
require 'will_paginate/array'

class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @user = User.find_by_id(params[:id])
    other_users = User.all :conditions => (current_user ? ["id != ?", current_user.id] : [])
    @users = other_users.paginate(page:  params[:page], per_page: 15, order: 'last_name')
  end

end