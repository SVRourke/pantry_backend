class BulkUserInfoSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
  
    
  has_many :friends, serializer: MinimalSerializer
  has_many :pending_friends, serializer: FriendsSerializer
  has_many :requests, key: :friend_requests, serializer: FriendRequestSerializer
  has_many :list_invites
  has_many :lists, serializer: MinimalSerializer
end
