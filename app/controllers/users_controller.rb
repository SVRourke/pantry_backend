class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.create(user_params)

        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { 
                user: UserSerializer.new(@user), 
                jwt: @token 
            }, 
            status: :created
        else
            render json: {
                error: 'failed to sign up',
                data: @user.errors
            }, status: :not_acceptable
        end
    end

    def show
        user = User.find(params[:id])

        if user.valid?
            render json: { user: UserSerializer.new(user) }, status: :created
        else
            render json: {
                error: 'Not Found',
            }, status: :not_acceptable
        end
    end

    private
    def user_params
        params.require(:user).permit(:password, :email, :name)
    end
    
end
