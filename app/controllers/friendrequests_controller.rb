class FriendrequestsController < ApplicationController
    # TODO: REFACTOR SIMPLIFY
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

    # * Accepts a parameter of type, either accept or decline to
    # * determine proper action to take 
    def update
        friend_request = Friendrequest.find(params[:id])

        if friend_request
            case params[:type]
            when 'accept'
                friend_request.accept
                render json: {message: "friend request accepted"}
            when 'decline'
                friend_request.destroy
                render json: {message: "friend request declined."}
            else
                render json: {message: "Something broke, try again later..."}
            end
        end
    end

    # TODO: Delete
    
end
