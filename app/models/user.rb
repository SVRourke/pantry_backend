# TODO: Validate email format

class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: true
    validates :email, presence: true
    validates :name, presence: true
    
    has_many :friendships, dependent: :destroy
    has_many :friends, through: :friendships

    # sent friend requests
    has_many :sent_requests, foreign_key: :requestor_id, class_name: 'Friendrequest', dependent: :delete_all
    # requested users, new request created by pushing user onto this list
    has_many :pending_friends, through: :sent_requests
    
    # recieved friend requests 
    has_many :requests, foreign_key: :pending_friend_id, class_name: 'Friendrequest', dependent: :delete_all
    # users requesting friendship
    has_many :requestors, through: :requests

    # recieved list_invites
    has_many :list_invites, foreign_key: :pending_contributor_id, class_name: 'ListInvite', dependent: :destroy
    has_many :sent_list_invites, foreign_key: :requestor_id, class_name: 'ListInvite', dependent: :destroy

    has_many :contributions, dependent: :destroy
    has_many :lists, through: :contributions, source: :list 

    def leave_list(list)
        contribution = Contribution.find_by(user: self, list: list)
        contribution.destroy
    end

    def unfriend(user)
        record = self.friendships.find_by(friend: user)
        record.destroy if record            
    end

    def all_list_invites
        return ListInvite.where(requestor_id: self.id).or(ListInvite.where(pending_contributor_id: self.id))
    end

    def all_requests
        return Friendrequest.where(requestor_id: self.id).or(Friendrequest.where(pending_friend_id: self.id))
    end
end
