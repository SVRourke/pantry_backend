class FriendshipsController < ApplicationController
    # DELETE /users/:user_id/friends/:id(.:format)        friendships#destroy
    # TODO: Index
    def index
        friends = current_user.friends
        render json: friends, include: [:id, :name]
    end
    # TODO: Delete
end
