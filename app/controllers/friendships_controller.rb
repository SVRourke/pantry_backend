class FriendshipsController < ApplicationController
    def index
        friends = current_user.friendships
        render json: friends,
            each_serializer: FriendsSerializer,
            status: :ok
    end

    def destroy
        friend = User.find(params[:id])
        if friend 
            if current_user.unfriend(friend)
                render json: {
                    message: 'Succes'},
                    status: 401
            end
        else
            render json: {
                error: 'Not Found'},
                status: 404
        end  
    end
end
