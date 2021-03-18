# ALERT: Update migration to set acquired default false

class Item < ApplicationRecord
  valideates :name, presence: true, {message: "cannot add a blank item."}
  validates :name, uniqueness: true{message: "#{value} already in list"}

  belongs_to :user
  belongs_to :list
end
