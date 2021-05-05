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
            render json: {
                error: "Unauthorized"},
                status: 401
        end
    end
    
    def create
        list = current_user.lists.create(new_list_params)        
        if list 
            render json: list,
            status: :ok
        else
            render json: {
                error: list.errors.full_messages},
                status: 422
        end
    end
    
    def destroy
        list = List.find(params[:id])

        if current_user.lists.include?(list)
            list.destroy
            render json: {
                message: "List destroyed"},
                status: 410

        else
            render json: {
                error: "Unauthorized"},
                status: 401
        end
    end

    def leave
        list = List.find(params[:list_id])
        if list
            current_user.leave_list(list) 
            render json: {
                message: 'Left List'},
                status: 410 
        else
            render json: {
                error: 'Not Found'},
                status: 404
        end
    end

    private

    def new_list_params
        params.require(:list).permit(:name)
    end
end
