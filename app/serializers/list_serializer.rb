# require './item_serializer.'
class ListSerializer < ActiveModel::Serializer
  attributes :id, :name, :items
  has_many :contributions

  def items
    object.items.map { |i| [i.id, ItemSerializer.new(i)] }.to_h
  end

end


# {
#   "id": 4,
#   "name": "3 mangoes",
#   "amount": "",
#   "acquired": null,
#   "record_age": 28945
# },