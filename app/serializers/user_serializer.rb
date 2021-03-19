# class FriendSerializer < ActiveModel::Serializer
#   attributes :id, :name
# end
# ? MAYBE DELETE ?
class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name
end

