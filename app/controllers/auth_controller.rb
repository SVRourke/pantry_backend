# TODO: GO OVER STATUSES
class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]
    
    def create
        user = User.find_by(email: login_params[:email])

        if user && user.authenticate(login_params[:password])
            render json: {  
                jwt: encode_token(user_id: user.id)}, 
                status: :created
        else
            unauthorized_message()
        end
    end

    def destroy
        token = decoded_token()

        if token
            DeniedJti.create!(jti: token['jti'], expiration: token['exp'])
            render json: {message: "logged  out"}, status: :gone
        end
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
