class FriendshipsController < ApplicationController
    def index
        friends = current_user.friends
        render json: 
            friends, 
            include: [:id, :name],
            status: :ok
    end

    def destroy
        friend = User.find(params[:id])
        if friend
            current_user.unfriend(friend)
            render json: {
                message: "Unfriended #{friend.name}"},
                status: :ok
        else
            render json: {
                message: "unable to complete request"}, 
                status: :not_found
        end
    end
end
