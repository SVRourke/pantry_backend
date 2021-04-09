class ListIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :contributor_count, :item_count, :contributors
  
  def contributor_count
    object.contributors.count
  end

  def item_count
    object.items.count
  end
end
