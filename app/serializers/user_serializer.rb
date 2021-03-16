class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name

  has_many :friends
  has_many :pending_friends
  has_many :requests, key: :requests
  has_many :list_invites
  has_many :lists


end

