# ALERT: Update migration to set acquired default false

class Item < ApplicationRecord
  include ActiveModel::Validations
  validates_with ItemValidator

  belongs_to :user
  belongs_to :list
end
