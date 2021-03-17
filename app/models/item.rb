# ALERT: Update migration to set acquired default false
# TODO: validate name:presence

class Item < ApplicationRecord
  belongs_to :user
  belongs_to :list
end
