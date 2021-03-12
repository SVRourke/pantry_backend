class ListInvite < ApplicationRecord
  belongs_to :list
  belongs_to :sender
  belongs_to :pending_contributor
end
