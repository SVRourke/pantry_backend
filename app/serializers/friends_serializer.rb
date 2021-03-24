class FriendsSerializer < ActiveModel::Serializer
  attributes :id, :friend_name, :record_age
  
  def friend_name
    object.friend.name
  end

  # def friendship_age
  #   byebug
  #   fs = Friendship.where(user_id: current_user.id, friend_id: object)
  #   fs[0].record_age()
  # end
end
