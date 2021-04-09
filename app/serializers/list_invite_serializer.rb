class ListInviteSerializer < ActiveModel::Serializer
  attributes :id, :type, :list_name, :requestor_name, :requestee_name, :contributor_count, :record_age

  def list_name
    object.list.name
  end

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
