class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :username, :record_age, :item_count

  def username
    User.find(object.user_id).name
  end
end
