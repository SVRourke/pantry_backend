class ListsController < ApplicationController
    before_action :authenticate_user
    # TODO: Index
    def show
        list = List.all
        render json: list, include: [:contributors, :items]
    end

    # TODO: Create
    def create
        puts new_list_params

    end
    # TODO: Read
    # TODO: Delete

    private

    def new_list_params
        params.require(:list_info).permit(:name)
    end
end
