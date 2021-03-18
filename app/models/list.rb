# TODO: add logic to delete list no contributors left

class List < ApplicationRecord
    has_many :contributions, foreign_key: :list_id
    has_many :contributors, through: :contributions, source: :user

    has_many :items

    has_many :list_invites
    has_many :invited_users, through: :list_invites, source: :pending_contributor 

end
