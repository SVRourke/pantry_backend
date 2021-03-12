class Friendrequest < ApplicationRecord
  belongs_to :requestor
  belongs_to :pending_friend
end
