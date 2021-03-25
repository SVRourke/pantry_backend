class ListInviteSerializer < ActiveModel::Serializer
  attributes :id, :record_age, :requestor_name, :requestee_name, :contributor_count, :type

  def requestor_name
    object.requestor.name
  end

  def requestee_name
    object.pending_contributor.name
  end

  def contributor_count
    object.list.contributors.count
  end

  def type
    object.requestor == scope ? "sent" : "received";
  end

end
