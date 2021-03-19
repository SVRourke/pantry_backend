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
    
    # ALERT: Investigate what the rescue is for and make error message
    def create
        requestee = User.find_by(email: params[:email])

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

    def destroy
        req = Friendrequest.find(params[:id])
        if current_user == req.requestor
            req.destroy
            successful_destroy()
        else
            unauthorized_message()
        end
    end
    
end
