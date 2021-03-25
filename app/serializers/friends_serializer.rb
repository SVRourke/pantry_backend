class FriendsSerializer < ActiveModel::Serializer
  attributes :id, :friend_name, :record_age, :friend_id 
  
  def friend_name
    object.friend.name
  end

end
