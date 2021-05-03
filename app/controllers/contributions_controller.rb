class ContributionsController < ApplicationController
    def index
        list = List.find(params[:list_id])
        render json: list.contributions, status: :ok
    end
end
