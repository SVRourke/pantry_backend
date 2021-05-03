# TODO: add logic to delete list no contributors left

class List < ApplicationRecord
    has_many :contributions, foreign_key: :list_id, dependent: :destroy
    has_many :contributors, through: :contributions, source: :user

    has_many :items, dependent: :destroy

    has_many :list_invites, dependent: :destroy
    has_many :invited_users, through: :list_invites, source: :pending_contributor 

end
