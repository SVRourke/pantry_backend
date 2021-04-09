class FriendsSerializer < ActiveModel::Serializer
  attributes :id, :friend_name, :record_age, :friend_id, :mutual_list_count 
  
  def friend_name
    object.friend.name
  end

end
