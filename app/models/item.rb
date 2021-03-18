# ALERT: Update migration to set acquired default false

class Item < ApplicationRecord
  valideates :name, presence: true

  belongs_to :user
  belongs_to :list
end
