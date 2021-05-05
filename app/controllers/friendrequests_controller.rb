class FriendrequestsController < ApplicationController
    def index
        requests = current_user.all_requests

        render json:
            requests,
            each_serializer: FriendRequestSerializer,
            status: :ok
    end
    
    # ALERT: Investigate what the rescue is for and make error message
    def create
        requestee = User.find_by_email(params[:email].upcase)
        # byebug

        if requestee
            req = Friendrequest.new(
                requestor: current_user,
                pending_friend: requestee                
            )
            if req.save
                render json: {
                    message: "Request sent to #{requestee.name}"}, 
                    status: :created
            else
                render json: {
                    error: req.errors.full_messages},
                    status: 422
            end

        else
            render json: {error: 'Not Found'}, status: 404
        end
    end

    def update
        friend_request = Friendrequest.find(params[:id])

        if friend_request
            case params[:type]
            
            when 'accept'
                friend_request.accept
                render json: {
                    message: 'request accepted'},
                    status: 200
            
            when 'decline'
                friend_request.destroy
                render json: {
                    message: 'request deleted'},
                    status: 410
            
            else
                render json: {
                    error: 'SERIOUS Error'},
                status: 500
            end
        end
    end

    def accept
        friend_request = Friendrequest.find(params[:friendrequest_id])
        friend = friend_request.requestor

        if current_user === friend_request.pending_friend
            friend_request.accept()
            fs = current_user.friendships.find {|fs| fs.friend_id == friend.id}
            render json: fs, serializer: FriendsSerializer, status: :ok
        end
    end


    def destroy
        req = Friendrequest.find(params[:id])
        
        if current_user == req.requestor || current_user == req.pending_friend
            req.destroy
            render json: {
                message: 'request deleted'},
                status: 410
        else
            render json: {
                error: 'Unauthorized'},
                status: 401
        end

    end
    
end
