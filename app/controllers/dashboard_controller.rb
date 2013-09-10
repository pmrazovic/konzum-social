require 'bootstrap_pagination_helper'

class DashboardController < ApplicationController
  before_filter :check_for_authentication, :only => [:index]

  def index
  end

  def orders
    @account = current_user
  end

  def friends
    @friends = current_user.friends.order(:last_name).paginate(:page => params[:page], :per_page => 10)
  end

  def products
  end

  def recipes
  end

  def shopping_lists
  end

  def check_for_authentication
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end