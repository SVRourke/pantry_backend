class FriendRequestSerializer < ActiveModel::Serializer
  attributes :id, :user, :since


  def user
    User.find(object.requestor_id).name
  end

  # TODO: PRETTIFY DATE
  def since
    object.created_at
  end

end
