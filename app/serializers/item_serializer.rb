class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :amount, :acquired, :record_age
end
