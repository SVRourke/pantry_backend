
class ListInvitesController < ApplicationController
    def index
        invites = current_user.all_list_invites            
            render json: 
                invites,
                status: :ok
    end

    def create
        if !!User.find_by_email(params[:email])
            
            list = List.find(params[:list_id])
            user = User.find_by_email(params[:email])
            
            invite = list.list_invites.new( 
                requestor: current_user, 
                pending_contributor: user
            )
            if invite.save
                render json: {
                    list_invite: invite},
                    status: :created
            else
                model_errors(invite.errors.messages)
            end

        
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
