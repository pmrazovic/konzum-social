class UsersController < ApplicationController
  before_filter :authenticate_user!

  def profile
    @user = User.find_by_id(params[:id])
  end

end