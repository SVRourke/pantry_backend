class ListsController < ApplicationController
    def index
        lists = current_user.lists
        render json: lists, include: [:contributors]
    end

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

    # TODO: Read
    # TODO: Delete

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
