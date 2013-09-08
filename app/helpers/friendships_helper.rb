module FriendshipsHelper

  def friendship_status_for(friend_id)
    friendship = current_user.friendships.find_by_friend_id(friend_id)
    if friendship
      if friendship.pending
        return 'Pending'
      else
        return 'OK'
      end
    else
      return 'None'
    end
  end

end
