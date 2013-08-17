class AuthenticationsController < ApplicationController
  before_filter :authenticate_user!, :only => [:home, :index, :destroy]
  def index
    @authentications = current_user.authentications.all
  end

  def home
    
  end

  def facebook
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
     flash[:notice] = "Logged in Successfully"
     sign_in_and_redirect User.find(authentication.user_id)
    elsif current_user
     token = omni['credentials'].token
     token_secret = ""

     current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)

     flash[:notice] = "Authentication successful."
     sign_in_and_redirect current_user
    else
     user = User.new
     user.email = omni['extra']['raw_info'].email
     user.first_name = omni['extra']['raw_info'].first_name
     user.last_name = omni['extra']['raw_info'].last_name

     user.apply_omniauth(omni)

     if user.save
       flash[:notice] = "Logged in."
       sign_in_and_redirect User.find(user.id)             
     else
       session[:omniauth] = omni.except('extra')
       redirect_to new_user_registration_path
     end
    end
  end

  def twitter
    omni = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omni['provider'], omni['uid'])

    if authentication
     flash[:notice] = "Logged in Successfully"
     sign_in_and_redirect User.find(authentication.user_id)
    elsif current_user
     token = omni['credentials'].token
     token_secret = omni['credentials'].secret

     current_user.authentications.create!(:provider => omni['provider'], :uid => omni['uid'], :token => token, :token_secret => token_secret)
     flash[:notice] = "Authentication successful."
     sign_in_and_redirect current_user
    end   
  end

  def destroy
    
  end 
end