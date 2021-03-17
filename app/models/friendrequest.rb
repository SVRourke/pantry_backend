# TODO: Validates uniqueness
# TODO: Validates requested user is not already friends with requestor

class Friendrequest < ApplicationRecord
  belongs_to :requestor, class_name: 'User'
  belongs_to :pending_friend, class_name: 'User'

  def accept()
    self.update(accepted: true)
    if self.accepted
        self.requestor.friends.push(self.pending_friend)
        self.destroy
    end
end
end
