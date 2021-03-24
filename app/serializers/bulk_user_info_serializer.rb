class BulkUserInfoSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
  # attribute: :friend_requests, each_serializer: :FriendRequestSerializer
  attribute: list_requests: {each_serializer: MinimalSerializer}

  def friend_requests
    ActiveModel::Serializer::CollectionSerializer.new(object.all_requests.to_a, {each_serializer: FriendRequestSerializer})
  end
    
  def list_requests
    object.all_list_invites
  end
  
  has_many :friendships, key: :friends, serializer: FriendsSerializer
  # has_many :pending_friends, serializer: MinimalSerializer
  # has_many :requests, key: :friend_requests, serializer: FriendRequestSerializer
  # has_many :list_invites
  has_many :lists, serializer: MinimalSerializer
end
