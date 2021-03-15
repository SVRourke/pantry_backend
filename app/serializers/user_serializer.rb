class UserSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :email, :name
  
  has_many :requests
  has_many :list_invites
  has_many :lists
  has_many :friendships

  class FriendshipSerializer < ActiveModel::Serializer
    attributes :friend_id, :created_at
  end

end
