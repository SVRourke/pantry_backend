class ListInvitesController < ApplicationController
    # TODO: Validation 
    def create
        # /lists/:list_id/listinvites
        if !!User.find(params[:invited_user_id])
            
            invite = List.find(params[:list_id]).list_invites.create( 
                requestor: current_user, 
                pending_contributor: User.find(params[:invited_user_id])
            )

            render json: {
                message: "invitation sent"
            }, status: 200
        
        else
            render json: {
                message: "unable to complete request"
            },status: :unprocessable_entity
        end
    end


    # /lists/:list_id/list_invites/:id
    def update
        invite = ListInvite.find(params[:id])
        case params[:type]
        when 'accept'
            invite.accept
            render json: {
                message: "accepted invite"
            },
            status: :accepted
            
        when 'decline'
            invite.destroy
            render json: {
                message: "declined invite"
            },
            status: :accepted

        else
            render json: {
                message: "unable to complete request"
            }, 
            status: :unprocessable_entity
        end
    end
    
    # TODO: add coverage for edge cases
    def destroy
        list = List.find(params[:list_id])
        invite = ListInvite.find(params[:id])

        if current_user.lists.include?(list) && invite.requestor == current_user
            invite.destroy
            render json: {
                message: "deleted invite"
                }, 
                status: :accepted
        else
            render json: {
                message: "could not complete request"}, 
                status: :unprocessable_entity
        end
    end
end
