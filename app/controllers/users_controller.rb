class UsersController < ApplicationController
    skip_before_action :authenticate, only: :create
    serialization_scope :view_context

    def create
        user = User.new(
            name: user_params[:name],
            email: user_params[:email].upcase,
            password: user_params[:password]
        )

        if user.save
            render json: {
                jwt: build_jwt(user.id), 
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
