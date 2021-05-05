class ItemsController < ApplicationController

    def index
        items = Item.where(list_id: params[:list_id])
        render json: items, status: :ok
    end

    def create
        item = List.find(params[:list_id]).items.build(item_params)
        item.user = current_user
        if item.save 
            render json: item, status: :ok
        else
            render json: {
                error: item.errors.full_messages},
                status: 422
        end
    end

    def update
        item = Item.find(params[:item_id])
        
        if item.update(item_params)
            render json: {
                item: item, 
                msg: "Updated #{item.updated_at}"},
                status: :ok 
        else
            render json: {
                error: item.errors.full_messages},
                status: 422
        end
    end

    def destroy
        if List.find(params[:list_id]).contributors.include?(current_user)
            Item.find(params[:id]).destroy
            render json: {
                message: "Item deleted"},
                status: 410
        else
            render json: {
                error: "Not Found"},
                status: 404
        end
    end
    
    def acquire
        item = Item.find(params[:item_id])
        item.update(acquired: !item.acquired)
        
        if item.save
            render json: {
                messages: "item acquired"},
                status: :ok
        else
            render json: {
                error: item.errors.full_messages},
                status: 422
        end
    end

    private
    
    def item_params
        params.require(:item).permit(:name, :amount)
    end
end
