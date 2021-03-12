class ListInvite < ApplicationRecord
  belongs_to :requestor, class_name: 'User'
  belongs_to :pending_contributor, class_name: 'User'
  belongs_to :list, class_name: 'List'

  def accept
    if !Contribution.where(user_id: self.pending_contributor_id, list_id: self.list_id).any?
      self.list.contributors.push(self.pending_contributor)
      self.destroy
    end
  end
end
