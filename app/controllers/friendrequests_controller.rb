class FriendrequestsController < ApplicationController
    # /users/:user_id/friendrequests
    def index
        sent_requests = current_user.sent_requests
        received_requests = current_user.requests
        render json: {
            sent: sent_requests,
            received: received_requests},
            status: :ok
    end

    def create
        requestee = User.find_by(email: params[:email])

        if requestee
            begin
                current_user.pending_friends.push(requestee)
                render json: {
                    message: "Request sent to #{requestee.name}"}, 
                    status: :created

            rescue
                render json: {
                    message: "Could not add user with email: #{params[:email]}"}, 
                    status: :unprocessable_entity
            end

        else
            render json: {
                message: "could not find user with email #{params[:email]}"},
                status: :not_found
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
                render json: {
                    message: "friend request accepted"},
                    status: :ok
            
            when 'decline'
                friend_request.destroy
                render json: {
                    message: "friend request declined."},
                    status: :ok
            
            else
                render json: {
                    message: "Something broke, try again later..."},
                    status: :unprocessable_entity
            end
        end
    end

    def destroy
        req = Friendrequest.find(params[:id])
        if current_user == req.requestor
            req.destroy
            render json: {
                message: "Request Deleted!"},
                status: :gone

        else
            render json: {
                message: "You may only delete your own requests!"},
                status: :unauthorized
        end
    end
    
end
