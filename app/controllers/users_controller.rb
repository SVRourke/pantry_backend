class UsersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :authorized, only: [:create]

    def create
        user = User.create(
            name: user_params[:name],
            email: user_params[:email].upcase,
            password: user_params[:password]
        )
        # byebug

        if user.valid?
            render json: user, status: :created
            return
        end

        model_errors(user.errors.full_messages)
    end

    def show
        user = User.find(params[:id])
          
        if user && user == current_user
            render json: { 
                user: BulkUserInfoSerializer.new(user)}, 
                status: :ok
            return
        end
        unauthorized_message()
    end
    
    private

    def user_params
        params.require(:user).permit(:password, :email, :name)
    end    
end
