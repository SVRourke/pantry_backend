class ListSerializer < ActiveModel::Serializer
  attributes :id, :name  
  has_many :contributors
  has_many :items
end
