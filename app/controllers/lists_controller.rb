class ListsController < ApplicationController
    def index
        lists = current_user.lists
        render json: lists, include: [:contributors]
    end

    # TODO: Read
    
    def create
        list = current_user.lists.create(new_list_params)        
        
        if list
            render json: {
                message: "#{list.name} created #{list.created_at}"
            }
        else
            render json: {
                message: "Could not save list"
            }
        end
    end
    
    def destroy
        list = List.find(params[:id])
        if list && current_user.lists.include?(list)
            list.destroy
            render json: {message: "List Deleted"}
        else
            render json: {
                message: "Error, are you sure that's your list?"
            }
        end
    end

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
