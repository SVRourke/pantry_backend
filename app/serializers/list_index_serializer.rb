class ListIndexSerializer < ActiveModel::Serializer
  attributes :id, :name, :contributor_count
  
  def contributor_count
    object.contributors.count
  end
end
