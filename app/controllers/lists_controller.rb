# TODO: add serializers
class ListsController < ApplicationController
    def index
        render json: 
            current_user.lists,
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
        if list 
            render json: list,
            status: :ok
        else
            model_errors(list.errors.full_messages)
        end
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
        params.require(:list).permit(:name)
    end
end
