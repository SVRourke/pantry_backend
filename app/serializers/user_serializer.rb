class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
  has_many :friends
  has_many :requestors
  has_many :lists

end
