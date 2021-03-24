# TODO: add serializers
class ListsController < ApplicationController
    def index
        lists = current_user.lists
        render json: 
            lists, 
            each_serializer: ListIndexSerializer,
            status: :ok
    end

    def show
        list = List.find(params[:id])
        if current_user.lists.include?(list)
            render json: list, 
            status: :ok
        else
            unauthorized_message()
        end
    end
    
    def create
        list = current_user.lists.create(new_list_params)        
        list ? successful_create(list) : model_errors(list.errors.full_messages)
    end
    
    def destroy
        list = List.find(params[:id])

        if current_user.lists.include?(list)
            list.destroy
            successful_destroy()
        else
            unauthorized_message()
        end
    end

    def leave
        list = List.find(params[:list_id])
        current_user.leave_list(list) ? successful_destroy() : not_found()
    end

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
