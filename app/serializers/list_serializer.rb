# require './item_serializer.'
class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :item_count, :contributor_count


  def item_count
    object.items.count
  end

  def contributor_count
    object.contributions.count
  end

end


# {
#   "id": 4,
#   "name": "3 mangoes",
#   "amount": "",
#   "acquired": null,
#   "record_age": 28945
# },