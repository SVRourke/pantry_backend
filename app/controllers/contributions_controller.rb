class ContributionsController < ApplicationController
    # TODO: Index
    def index
        list = List.find(params[:list_id])
        render json: list.contributions, status: :ok
    end
    # TODO: Destroy
end
