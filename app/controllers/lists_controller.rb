# TODO: add serializers
class ListsController < ApplicationController
    def index
        lists = current_user.lists
        render json: lists, 
            include: [:contributors],
            status: :ok
    end

    def show
        list = List.find(params[:id])
        
        if list && current_user.lists.include?(list)
            render json: list, 
            status: :ok
        else
            render json: {
                message: "could not complete request"
            }, status: :not_found
        end
    end
    
    def create
        list = current_user.lists.create(new_list_params)        
        
        if list
            render json: {
                message: "#{list.name} created #{list.created_at}"
            }, status: :created
        else
            render json: {
                message: "Could not save list"
            }, status: :unprocessable_entity
        end
    end
    
    def destroy
        list = List.find(params[:id])
        
        if list && current_user.lists.include?(list)
            list.destroy
            render json: {
                message: "List Deleted"
            }, status: :gone
        else
            render json: {
                message: "Error, are you sure that's your list?"
            }, status: :bad_request
        end
    end

    def leave
        list = List.find(params[:list_id])

        if current_user.leave_list(list)
            render json: {
                message: "Left #{list.name}"
            }, status: :ok
        else
            render json: {
                message: "Error..."
            }, status: :unprocessable_entity
        end
    end

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
