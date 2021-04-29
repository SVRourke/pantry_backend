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
            model_errors(item.errors.full_messages);
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
            model_errors(item.errors.full_messages)
        end
    end

    def destroy
        if List.find(params[:list_id]).contributors.include?(current_user)
            Item.find(params[:id]).destroy
            successful_destroy()
        else
            unauthorized_message()
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
            model_errors(item.errors.full_messages)
        end
    end

    # ALERT: MAKE UNACQUIRE ACTION

    private
    
    def item_params
        params.require(:item).permit(:name, :amount)
    end
end
