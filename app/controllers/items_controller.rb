class ItemsController < ApplicationController
    # TODO: INDEX   GET    /lists/:list_id/items(.:format)              items#index
    def index
        items = Item.where(list_id: params[:list_id])
        render json: items
    end
    # TODO: Create  POST   /lists/:list_id/items(.:format)              items#create
    def create
        item = List.find(params[:list_id]).items.build(item_params)
        item.user = current_user
        
        if item.save
            render json: {
                message: "Saved Item"
            }, status: :accepted
        else
            render json: {
                message: "Error could not add #{item.name}"
            }, status: :unprocessable_entity
        end
    end
    # TODO: Read    GET    /lists/:list_id/items/:id(.:format)          items#show
    # TODO: Update  PATCH  /lists/:list_id/items/:id(.:format)          items#update
    # TODO: Delete  DELETE /lists/:list_id/items/:id(.:format)          items#destroy
    
    # TODO: Mark Acquired

    private
    
    def item_params
        params.require(:item).permit(:name, :amount)
    end
end
