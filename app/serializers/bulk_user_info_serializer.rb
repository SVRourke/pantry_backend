class BulkUserInfoSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :list_count, :friend_count, :sent_requests, :received_requests, :sent_invites, :received_invites

  def email
    object.email.downcase
  end

  def list_count
    object.lists.count
  end

  def friend_count
    object.friends.count
  end

  def sent_requests
    object.pending_friends.count
  end

  def received_requests
    object.requestors.count
  end

  def sent_invites
    object.list_invites.count
  end
  
  def received_invites
    object.sent_list_invites.count
  end  
end