module FriendshipsHelper

  def friendship_status(user1, user2)
    friendship = user1.friendships.find_by_friend_id(user2)
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
