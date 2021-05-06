class ApplicationController < ActionController::API
    before_action :authenticate

    rescue_from 'JWT::ExpiredSignature' do |exception|
        render json: {
            error: "Please Log In"},
            status: 401
    end

    def logged_in?
        !!current_user
    end

    def current_user
        if auth_present?
            user = User.find(decoded_token['id'])

            if user
                @current_user ||= user
            end
        end
    end

    def authenticate
        unless logged_in?
            render json: {error: 'unauthorized'}, status: 401
        end
    end

    def build_jwt(id)
        payload = {
            'iss': 'pantry-api',
            'exp': 1.hour.from_now.to_i,
            'id': id
        }
        return JWT.encode payload, ENV["JWT_KEY"], 'HS256'
    end

  

    private

    def token
        request.headers['Authorization']
    end
    
    def decoded_token
        begin
            t = JWT.decode token(), ENV["JWT_KEY"], true, { algorithm: 'HS256' }
            t[0]
        rescue
            return false
        end
    end

    def auth_present?
        !!decoded_token()
    end
    
end

