
class ListInvitesController < ApplicationController
    def index
        if current_user.id == params[:user_id].to_i
            invites = current_user.list_invites
            
            render json: 
                invites,
                status: :ok
            
        else
            unauthorized_message()
        end
    end

    def create
        if !!User.find(params[:invited_user_id])
            
            invite = List.find(params[:list_id]).list_invites.create( 
                requestor: current_user, 
                pending_contributor: User.find(params[:invited_user_id])
            )

            render json: {
                message: "invitation sent"},
                status: :created
        
        else
            not_found()
        end
    end

    def update
        invite = ListInvite.find(params[:id])
        
        case params[:type]
        when 'accept'
            invite.accept
            request_accepted()
            
        when 'decline'
            invite.destroy
            request_declined()

        else
            something_broke()
        end
    end
    
    # ALERT: REDO
    def destroy
        list = List.find(params[:list_id])
        invite = ListInvite.find(params[:id])

        if current_user.lists.include?(list) && invite.requestor == current_user
            invite.destroy
            render json: {
                message: "deleted invite"}, 
                status: :gone
        else
            render json: {
                message: "could not complete request"}, 
                status: :bad_request
        end
    end
end
