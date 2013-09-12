class LikesController < ApplicationController
  before_filter :authenticate_user!

  def create
    @new_like = Like.new(:user_id => current_user.id, 
                        :likeable_id => params[:likeable_id], 
                        :likeable_type => params[:likeable_type])
    @new_like.save
    render :action => 'create.js.erb'
  end

  def destroy
    like = Like.find(params[:id])
    @likeable_id = like.likeable_id
    @likeable_type = like.likeable_type
    like.destroy
    render :action => 'destroy.js.erb'
  end

end