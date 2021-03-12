  # TODO: FIX list_invites reference

class List < ApplicationRecord
    has_many :contributions
    has_many :contributors, through: :contributions, source: :user

    has_many :items

    has_many :list_invites
    has_many :invited_users, through: :list_invites, source: :pending_contributor 
end
