# TODO: Validates requested user is not already friends with requestor

class FriendrequestValidator < ActiveModel::Validator
    def validate(record)
        requestor = record.requestor
        pending_friend = record.pending_friend

        if !!Friendrequest.where(requestor: requestor, pending_friend: pending_friend).any?
            record.errors.add :redundant, "request exists"
        elsif requestor.friends.include?(pending_friend)
            record.errors.add :existing, "already friends"
        end
    end
end