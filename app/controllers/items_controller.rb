class ItemsController < ApplicationController
    def index
        items = Item.where(list_id: params[:list_id])
        render json: 
            items,
            status: :ok
    end

    def create
        item = List.find(params[:list_id]).items.build(item_params)
        item.user = current_user
        
        if item.save
            render json: {
                message: "Saved Item"}, 
                status: :created
        else
            render json: {
                message: "Error could not add #{item.name}"},
                status: :unprocessable_entity
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
                message: "could not complete request"},
                status: :unprocessable_entity
        end
    end

    def destroy
        if List.find(params[:list_id]).contributors.include?(current_user)
            Item.find(params[:id]).destroy
            render json: {
                message: "Deleted item"},
                status: :gone
        else
            render json: {
                message: "could not complete request"},
                status: :not_found
        end
    end
    
    def acquire
        item = Item.find(params[:item_id])
        item.update(acquired: true)
        
        if item.save
            render json: {
                messages: "Updated item"},
                status: :ok
        else
            render json: {
                message: "error..."},
                status: :unprocessable_entity
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