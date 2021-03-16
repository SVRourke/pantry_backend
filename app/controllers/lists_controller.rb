class ListsController < ApplicationController
    # TODO: Index
    def index
        list = List.all
        render json: list, include: [:contributors, :items]
    end

    # TODO: Create
    def create
        puts new_list_params
        # current_user.lists.create(name: new_list_params)
        # if good return good, else return error
    end

    end
    # TODO: Read
    # TODO: Delete

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
