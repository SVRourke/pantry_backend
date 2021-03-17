class FriendshipValidator < ActiveModel::Validator
    def validate(record)
        if Friendship.find_by(user: record.user, friend: record.friend)
            record.errors.add :existing_record, "friendship already exists"
        end
    end
end