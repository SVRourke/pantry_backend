class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
    # CREATE 'login'
    def create
        user = User.find_by(email: login_params[:email])
        
        if user && user.authenticate(login_params[:password])
            render json: { 
                user: UserSerializer.new(user), 
                jwt: encode_token(user_id: user.id) 
            }, 
            status: :accepted
        else
            render json: {
                error: 'failed to login',
            }, status: :not_acceptable
        end

    end

    # TODO: ADD JWT Denylist
    def destroy
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
