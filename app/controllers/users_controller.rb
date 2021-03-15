class UsersController < ApplicationController

    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: { user: UserSerializer.new(@user) }, status: :created
        else
            render json: {
                error: 'failed to sign up',
                data: @user.errors.full_messages.to_sentence
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
