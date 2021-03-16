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
    def destroy
        if List.find(params[:list_id]).contributors.include?(current_user)
            Item.find(params[:id]).destroy
            render json: {message: "Deleted item"}, status: :accepted
        else
            render json: {message: "could not complete request"}
        end
    end
    
    def acquire
        item = Item.find(params[:item_id])
        item.update(acquired: true)
        
        if item.save
            render json: { messages: "Updated item"}, status: :accepted
        else
            render json: {
                message: "error..."
            }
        end
    end

    private
    
    def item_params
        params.require(:item).permit(:name, :amount)
    end
end


# list_item_update PUT    /lists/:list_id/items/:item_id/update(.:format)  items#update
# list_item_acquire PATCH  /lists/:list_id/items/:item_id/acquire(.:format) items#acquire
# list_items GET    /lists/:list_id/items(.:format)                  items#index
#             POST   /lists/:list_id/items(.:format)                  items#create
# list_item GET    /lists/:list_id/items/:id(.:format)              items#show