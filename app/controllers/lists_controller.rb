class ListsController < ApplicationController
    def index
        lists = current_user.lists
        render json: lists, include: [:contributors]
    end

    # TODO: create listserializer
    def show
        list = List.find(params[:id])
        if list && current_user.lists.include?(list)
            render json: list, status: :accepted
        else
            render json: {
                message: "could not complete request"
            }, status: :unprocessable_entity
        end
    end
    
    def create
        list = current_user.lists.create(new_list_params)        
        
        if list
            render json: {
                message: "#{list.name} created #{list.created_at}"
            }, status: :accepted
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
            }, status: :accepted
        else
            render json: {
                message: "Error, are you sure that's your list?"
            }, status: :unprocessable_entity
        end
    end

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
