class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
    # CREATE 'login'
    def create
        user = User.find_by(email: login_params[:email])
        
        if user.authenticate(login_params[:password])
            @token = encode_token(user_id: user.id)
            render json: { 
                user: UserSerializer.new(user), 
                jwt: @token 
            }, 
            status: :accepted
        else
            render json: {
                error: 'failed to login',
            }, status: :not_acceptable
        end

    end

    # DESTROY 'logout'
    def destroy
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
