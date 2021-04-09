# TODO: Validate friendship:unique

class Friendship < ApplicationRecord
    include ActiveModel::Validations
    validates_with FriendshipValidator

    belongs_to :user
    belongs_to :friend, class_name: 'User'

    after_create :reciprocate_friendship
    after_destroy :remove_reciprocal

    def mutual_list_count
        a = User.find(self.user_id)
        b = User.find(self.friend_id)
        self.user.lists.filter { |l| l.contributors.includes(self.friend)}.count
      end

    private

        def reciprocate_friendship
            if !Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)
                Friendship.create(user_id: self.friend_id, friend_id: self.user_id)
            end
        end

        def remove_reciprocal
            opposite_friendship = Friendship.find_by(user_id: self.friend_id, friend_id: self.user_id)

            if opposite_friendship
                opposite_friendship.destroy        
            end
        end
end
