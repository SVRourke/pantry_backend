class FriendRequestSerializer < ActiveModel::Serializer
  attributes :id, :requestor_id, :requestor_name, :requestee_name, :type, :record_age


  def requestor_name
    object.requestor.name
  end

  def requestee_name
    object.pending_friend.name
  end

  def type
    object.requestor == current_user ? "sent" : "received";
  end

end
