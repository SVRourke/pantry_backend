class ApplicationController < ActionController::API
    before_action :authorized
    
    include ActionController::Cookies
    include ActionController::RequestForgeryProtection

    protect_from_forgery with: :exception
    before_action :set_csrf_cookie

    def bake_cookie(id)
        cookies.signed[:id] = {
            value: id,
            httponly: true,
            expires: 1.day.from_now,
            domain: 'svrourke.com'
        }
    end

    def current_user
        current_user = current_user ||= User.find(cookies.signed[:id])
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

    private

    def set_csrf_cookie
        cookies["CSRF-TOKEN"] = form_authenticity_token
    end

end

    

