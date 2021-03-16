class ItemsController < ApplicationController
    # TODO: INDEX   GET    /lists/:list_id/items(.:format)              items#index
    def index
        items = Item.where(list_id: params[:list_id])
        render json: items
    end
    # TODO: Create  POST   /lists/:list_id/items(.:format)              items#create
    # TODO: Read    GET    /lists/:list_id/items/:id(.:format)          items#show
    # TODO: Update  PATCH  /lists/:list_id/items/:id(.:format)          items#update
    # TODO: Delete  DELETE /lists/:list_id/items/:id(.:format)          items#destroy
    
    # TODO: Mark Acquired
end
