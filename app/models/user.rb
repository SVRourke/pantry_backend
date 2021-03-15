class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true
    
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    # sent friend requests
    has_many :sent_requests, foreign_key: :requestor_id, class_name: 'Friendrequest'
    # requested users, new request created by pushing user onto this list
    has_many :pending_friends, through: :sent_requests
    
    # recieved friend requests 
    has_many :requests, foreign_key: :pending_friend_id, class_name: 'Friendrequest'
    # users requesting friendship
    has_many :requestors, through: :requests

    # recieved list_invites
    has_many :list_invites, foreign_key: :pending_contributor_id, class_name: 'ListInvite'

    has_many :contributions
    has_many :lists, through: :contributions, source: :list 


end
