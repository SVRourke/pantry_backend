class FriendrequestsController < ApplicationController
    # TODO: Create
    def create
        failMessage = {message: "Could not add user with email: #{params[:email]}"}
        pendingFriend = User.find_by(email: params[:email])
        if pendingFriend
            begin
                current_user.pending_friends.push(pendingFriend)
                render json: {message: "Request sent to #{pendingFriend.name}"}, status: :accepted
            rescue
                render json: failMessage, status: :unprocessable_entity
            end
        else
            render json: {message: "could not find user with email #{params[:email]}"}
        end
    end

    # TODO: Accept SWITCH TO UPDATE for better Syntax
    def accept
        friend_request = Friendrequest.find(params[:friendrequest_id])
        
        if friend_request 
            friend_request.accept
            render json: {message: "You're now friends with #{User.find(params[:requestor_id]).name}"}
        else
            render json: {message: "Something broke, try again later..."}
        end
    end
    # TODO: Decline
    def decline
    end
    # TODO: Delete
end
