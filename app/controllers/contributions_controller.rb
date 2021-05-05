class ContributionsController < ApplicationController
    def index
        list = List.find(params[:list_id])
        if list
            render json: list.contributions, status: 200
        else
            render json: {message: 'Not Found'}, status: 404
        end
    end
end
