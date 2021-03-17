class Contribution < ApplicationRecord
  include ActiveModel::Validations
  validates_with ContributionValidator
  
  belongs_to :user
  belongs_to :list
end
