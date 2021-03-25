class BulkUserInfoSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :lists, :friend_requests, :list_requests

  def friend_requests
    object.all_requests.map do |fr|
      FriendRequestSerializer.new(fr)
    end
  end
    
  def list_requests
    object.all_list_invites.map do |lr|
      ListInviteSerializer.new(lr)
    end
  end

  def lists
    object.lists.map do |l|
      ListSerializer.new(l)
    end
  end
  
  has_many :friendships, key: :friends, serializer: FriendsSerializer
end