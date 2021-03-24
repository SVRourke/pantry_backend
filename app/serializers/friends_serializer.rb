class FriendsSerializer < ActiveModel::Serializer
  attributes :id, :name, :friendship_age

  def friendship_age
    fs = Friendship.where(user_id: current_user.id, friend_id: object)
    # byebug
    fs[0].record_age()
  end
end
