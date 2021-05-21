# TODO: GO OVER STATUSES
class AuthController < ApplicationController
    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :authorized, only: :create
    
    def create
        user = User.find_by_email(login_params[:email].upcase())

        if user 
            if user.authenticate(login_params[:password])
                # session[:user_id] = user.id
                bake_cookie(user.id)
                render json: {
                    id: user.id}, status: :created
            end
        else
            render json: {
                error: 'Not Found'},
                status: 404

        end
    end
    
    def destroy
        # TODO: FIGURE THIS ONE OUT
        cookies.delete( :id, domain: 'svrourke.com')
        render json: {
            message: 'record deleted'},
            status: 410
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
