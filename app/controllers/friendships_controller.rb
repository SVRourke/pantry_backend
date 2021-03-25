class FriendshipsController < ApplicationController
    def index
        friends = current_user.friendships
        render json: friends,
            each_serializer: FriendsSerializer,
            status: :ok
    end

    def destroy
        friend = User.find(params[:id])
        friend && current_user.unfriend(friend) ? successful_destroy() : not_found()
    end
end
