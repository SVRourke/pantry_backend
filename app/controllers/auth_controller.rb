# TODO: GO OVER STATUSES
class AuthController < ApplicationController
    skip_before_action :authenticate, only: [:create]
    serialization_scope :view_context

    def create
        user = User.find_by_email(login_params[:email].upcase())

        if user 
            if user.authenticate(login_params[:password])
                render json: {
                    jwt: build_jwt(user.id),
                    id: user.id}, status: :created
            end
        else
            render json: {
                error: 'Not Found'},
                status: 404

        end
    end
    
    # user for refresh/reissue i think
    # def check_auth
    #     if logged_in?
    #         render json: {
    #             userId: current_user(),
    #             jwt: request.headers["Authorization"],
    #         }, status: 200
    #     else
    #         unauthorized_message()
    #     end
    # end

    def destroy
        # TODO: FIGURE THIS ONE OUT
        render json: {
            message: 'record deleted'},
            status: 410
    end

    private

    def login_params
        params.require(:user).permit(:email, :password)
    end

end
