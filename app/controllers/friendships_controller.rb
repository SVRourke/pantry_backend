class FriendshipsController < ApplicationController
    def index
        friends = current_user.friends
        render json: friends, include: [:id, :name]
    end

    def destroy
        friend = User.find(params[:id])
        if friend
            current_user.unfriend(friend)
            render json: {
                message: "Unfriended #{friend.name}"
            }, status: 200
        else
            render json: {
                message: "unable to complete request"
            }, status: :unprocessable_entity
        end
    end
end
