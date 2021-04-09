class ListSerializer < ActiveModel::Serializer
  attributes :id, :name  
  has_many :contributions
  has_many :items
end
