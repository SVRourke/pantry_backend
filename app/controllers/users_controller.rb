class UsersController < ApplicationController
    skip_before_action :authorized, only: :create
    serialization_scope :view_context
    skip_before_action :verify_authenticity_token, only: :create

    def create
        user = User.new(
            name: user_params[:name],
            email: user_params[:email].upcase,
            password: user_params[:password]
        )

        if user.save
            # session[:user_id] = user.id
            bake_cookie(user.id)
            render json: {
                id: user.id},
                status: :created
            return
        end

        render json: {
            error: 'user.errors.full_messages'},
            status: 422
    end

    def show
        render json: { 
            user: BulkUserInfoSerializer.new(current_user)}, 
            status: :ok
        return
    end

    def destroy
        current_user.destroy
        render json: {
            message: 'User Deleted'},
            status: 410
    end
    
    private

    def user_params
        params.require(:user).permit(:password, :email, :name)
    end    
end
