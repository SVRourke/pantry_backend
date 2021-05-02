class FriendrequestsController < ApplicationController
    # /users/:user_id/friendrequests
    def index
        requests = current_user.all_requests

        render json:
            requests,
            each_serializer: FriendRequestSerializer,
            status: :ok
    end
    
    # ALERT: Investigate what the rescue is for and make error message
    def create
        requestee = User.find_by_email(params[:email].upcase.upcase)

        if requestee
            begin
                current_user.pending_friends.push(requestee)
                render json: {
                    message: "Request sent to #{requestee.name}"}, 
                    status: :created

            rescue
                something_broke()
            end

        else
            not_found()
        end
    end

    def update
        friend_request = Friendrequest.find(params[:id])

        if friend_request
            case params[:type]
            
            when 'accept'
                friend_request.accept
                request_accepted()
            
            when 'decline'
                friend_request.destroy
                request_declined()
            
            else
                something_broke()
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
        else
            something_broke()
        end
    end


    def destroy
        req = Friendrequest.find(params[:id])
        
        if current_user == req.requestor || current_user == req.pending_friend
            req.destroy
            successful_destroy()
        else
            unauthorized_message()
        end

    end
    
end
