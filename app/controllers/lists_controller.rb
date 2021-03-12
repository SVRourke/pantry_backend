class ListsController < ApplicationController
    # TODO: Index
    def index
        list = List.all
        render json: list, include: [:contributors, :items]
    end
    # TODO: Create
    # TODO: Read
    # TODO: Delete
end
