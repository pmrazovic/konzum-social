class FriendshipsController < ApplicationController

  # friendships -> post, send friendship request
  def create
    friendship = current_user.friendships.build(friend_id: params[:friend_id])
    friendship.pending = true
    if friendship.save
      flash[:notice] = "Added friend."
      redirect_to profile_user_url(current_user)
    else
      flash[:notice] = "Unable to add friend."
      redirect_to :back
    end
  end

  # friendship -> put, accept request
  def update
    friendship = current_user.friendships.build(friend_id: params[:friend_id], pending: false)
    friendship.save
    inverse_friendship = current_user.inverse_friendships.find_by_user_id(params[:friend_id])
    inverse_friendship.pending = false
    inverse_friendship.save
    redirect_to :back
  end

  # friendship -> delete, delete all friendships between 
  # user and friend (pending and non-pending)
  # NOTE: facebook friendships will be recreated after login
  def destroy
    delete_friendship(current_user, params[:friend_id])
    delete_friendship(params[:friend_id], current_user)    
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Friendship destroyed.' }
      format.json { head :ok }
    end
  end

  def delete_friendship(u1, u2)
    if friendship = Friendship.where(user_id: u1, friend_id: u2).first
      friendship.destroy
    end
  end
end
