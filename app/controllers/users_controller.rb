class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    
    # TODO: create serializer for single user no associations
    # MAYBE refactir out and just send friend requests via request create action
    def search
        user = User.find_by(email: params[:email])
        if user
            render json: user, status: :accepted
        else
            render json: {message: "could not find user with email #{params[:email]}"}
        end
    end

    # route to test auth
    def profile
        render json: {
            user: UserSerializer.new(current_user)
        }, 
        status: :accepted
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: { 
                user: UserSerializer.new(@user), 
                jwt: encode_token(user_id: @user.id) 
            }, 
            status: :created
        else
            render json: {
                error: 'failed to sign up',
                data: @user.errors
            }, 
            status: :not_acceptable
        end
    end

    def show
        user = User.find(params[:id])

        if user.valid?
            render json: { 
                user: UserSerializer.new(user) 
            }, 
            status: :created
        else
            render json: {
                error: 'Not Found',
            }, 
            status: :not_acceptable
        end
    end

    private

    def user_params
        params.require(:user).permit(:password, :email, :name)
    end
    
end
