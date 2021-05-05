
class ListInvitesController < ApplicationController
    def index
        invites = current_user.all_list_invites            
            render json: 
                invites,
                status: :ok
    end

    def accept
        invite = ListInvite.find(params[:list_invite_id])
        if current_user == invite.pending_contributor
            list = invite.list
            invite.accept()
            
            render json:
                list,
                status: :ok
        else
            render json: {
                error: "Unauthorized"},
                status: 401
        end
        
    end

    def create
        if !!User.find_by_email(params[:email].upcase)
            
            list = List.find(params[:list_id])
            user = User.find_by_email(params[:email].upcase)
            
            invite = list.list_invites.new( 
                requestor: current_user, 
                pending_contributor: user
            )
            if invite.save
                render json: {
                    list_invite: invite},
                    status: :created
            else
                render json: {
                    error: invite.errors.full_messages},
                    status: 422
            end

        
        else
            render json: {
                error: "Not Found"},
                status: 404
        end
    end

    def update
        invite = ListInvite.find(params[:id])
        
        case params[:type]
        when 'accept'
            invite.accept
            render json: {
                message: "Request accepted!"},
                status: 200
            
        when 'decline'
            invite.destroy
            render json: {
                message: "Request deleted"},
                status: 410

        else
            render json: {
                error: "SERIOUS Error"},
                status: 400
        end
    end
    
    # ALERT: REDO
    def destroy
        invite = ListInvite.find(params[:id])
        if invite
            invite.destroy
            render json: {
                message: "deleted invite"}, 
                status: :gone
        else
            render json: {
                error: "Not Found"},
                status: 404
        end
    end
end
