class DashboardController < ApplicationController
  before_filter :check_for_authentication, :only => [:index]

  def index
  end

  def check_for_authentication
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end