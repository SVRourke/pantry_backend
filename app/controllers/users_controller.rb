class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    
    # TODO: create serializer for single user no associations
    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: { 
                user: BulkUserInfoSerializer.new(@user), 
                jwt: encode_token(user_id: @user.id) 
            }, 
            status: :created
        else
            render json: {
                error: 'failed to sign up',
                data: @user.errors
            }, 
            status: :unprocessable_entity
        end
    end

    def show
        user = User.find(params[:id])

        if user.valid?
            render json: { 
                user: BulkUserInfoSerializer.new(user) 
            }, 
            status: :ok
        else
            render json: {
                error: 'Not Found',
            }, 
            status: :not_found
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :email, :name)
    end
    
end
