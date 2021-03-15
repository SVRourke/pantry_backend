class ApplicationController < ActionController::API
    before_action :authorized 

    def encode_token(payload)
        # TODO: CHANGE TO AN ENV REF IMMEDIATELY
        JWT.encode(payload, 'MYSECRET')
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token(token)
        if auth_header
            token = auth_header.split(' ')[1]

            begin
                # TODO: CHANGE TO AN ENV REF IMMEDIATELY
                JWT.decode(token, 'MYSECRET')[0]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!current_user
    end
end
