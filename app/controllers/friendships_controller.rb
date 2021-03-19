class FriendshipsController < ApplicationController
    def index
        friends = current_user.friends
        render json: friends, status: :ok
    end

    def destroy
        friend = User.find(params[:id])
        friend && current_user.unfriend(friend) ? successful_destroy() : not_found()
    end
end
