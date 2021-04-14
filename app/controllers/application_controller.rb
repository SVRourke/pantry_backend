class ApplicationController < ActionController::API
    include ::ActionController::Cookies
    include ::ActionController::RequestForgeryProtection
    protect_from_forgery
    before_action :set_csrf_cookie
    before_action :authorized

    # TODO: ADD BEFORE EVERY AUTHORIZED

    def bake_cookies(id)
        cookies.signed[:id] = {
            value: id,
            httponly: true,
            expires: 1.day.from_now
        }
    end
    
    def current_user
        if cookies.signed[:id]
            @user = User.find_by(id: cookies.signed[:id])
        end
    end

    def logged_in?
        !!current_user
    end

    def authorized
        render json: { 
            message: 'Please log in' 
        }, 
        status: :unauthorized unless logged_in?
    end


    # Response Messages
    def something_broke
        render json: {
            message: "Something broke, try again later..."},
            status: :unprocessable_entity
    end

    def not_found()
        render json: {
            error: "Not Found"},
            status: :not_found
    end

    def model_errors(error_messages)
        render json: {
            error: error_messages},
            status: :unprocessable_entity
    end

    def unauthorized_message
        render json: {
            error: "Not Authorized"},
            status: :unauthorized
    end

    def request_accepted
        render json: {
            message: "request accepted"},
            status: :ok
    end

    def request_declined
        render json: {
            message: "request declined."},
            status: :ok
    end

    def successful_destroy
        render json: {
            message: "record deleted!"},
            status: :gone
    end

    def successful_create(record)
        render json: {
            message: "#{record.name} created #{record.created_at}",
            id: record.id
        }, 
            status: :created
    end

    private
    
    def set_csrf_cookie
        cookies["CSRF-TOKEN"] = form_authenticity_token
    end


end
