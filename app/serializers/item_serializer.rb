class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :acquired
end
