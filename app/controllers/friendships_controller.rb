class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    @friendship.pending = true
    if @friendship.save
      flash[:notice] = "Added friend."
      redirect_to profile_user_url(current_user)
    else
      flash[:notice] = "Unable to add friend."
      redirect_to profile_user_url(current_user)
    end
  end
end
