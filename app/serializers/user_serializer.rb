class UserSerializer < ActiveModel::Serializer
  
  class FriendsSlice < ActiveModel::Serializer
    attributes :id, :name, :friends_since
    def friends_since
      Friendship.find_by(friend_id: object.id).created_at
    end
  end
  
  class FriendRequestSerializer < ActiveModel::Serializer
    attributes :id, :requestor_id, :requestor_name
    def requestor_name
      User.find(object.requestor_id).name
    end
  end
  
  class PendingFriendSerializer < ActiveModel::Serializer
    attributes :id, :pending_name

    def pending_name
      User.find(object.requestor_id).name
    end
  end

  attributes :id, :email, :name

  has_many :friends, serializer: FriendsSlice
  has_many :pending_friends, serializer: PendingFriendSerializer
  has_many :requests, key: :friend_requests, serializer: FriendRequestSerializer
  has_many :list_invites
  has_many :lists



end

