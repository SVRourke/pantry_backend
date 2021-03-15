class UsersController < ApplicationController
    def create
        puts ''
        puts user_params
        puts ''
        puts user_params
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

    private
    def user_params
        params.require(:user).permit(:password, :email, :name)
    end

end
