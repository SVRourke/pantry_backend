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
        }
        Rails.env != 'development' ? cookies["CSRF-TOKEN"]['domain'] = 'svrourke.com' : nil
    end

    def current_user
        cookies.signed[:id] ? current_user ||= User.find(cookies.signed[:id]) : false
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
        cookies["CSRF-TOKEN"] = {
            value: form_authenticity_token,
            httponly: false
        }
        Rails.env != 'development' ? cookies["CSRF-TOKEN"]['domain'] = 'svrourke.com' : nil
    end

end

    

