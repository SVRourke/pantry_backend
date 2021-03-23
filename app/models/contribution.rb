class Contribution < ApplicationRecord
  include ActiveModel::Validations
  validates_with ContributionValidator
  
  after_destroy :check_if_last

  belongs_to :user
  belongs_to :list

  def check_if_last
    self.list.destroy if !self.list.contributors.any?
  end

  def item_count
    self.list.items.where(user_id: self.user_id).count
  end
end
