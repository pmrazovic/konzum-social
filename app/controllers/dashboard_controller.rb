class DashboardController < ApplicationController
  before_filter :check_for_authentication, :only => [:index]

  def index
    @graph = Koala::Facebook::API.new(current_user.authentications.first.token)
    @profile = @graph.get_object("me")
    @friends = @graph.get_connections("me", "friends")
  end

  def check_for_authentication
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end