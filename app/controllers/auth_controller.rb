# TODO: GO OVER STATUSES
class AuthController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :authorized, only: :create

    def create
        user = User.find_by_email(login_params[:email].upcase)
        set_csrf_cookie()

        if user && user.authenticate(login_params[:password])
            bake_cookies(user.id)

            render json: {  
                id: user.id,
                status: :created
            }
        else
            unauthorized_message()
        end
    end

    def check_auth
        if logged_in? 
            render json: {
                id: current_user.id,
                status: :authorized
            }
        else
            unauthorized_message()
        end    

    end

    def destroy
        session.clear

        successful_destroy()
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
