class ApplicationController < ActionController::API
    before_action :authorized 
    
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :model_errors

    def encode_token(payload)
        
        jti_raw = [
            ENV['JWT_SECRET'], 
            Time.now.to_i].join(':').to_s
        
        jti = Digest::MD5.hexdigest(jti_raw)

        JWT.encode(
            payload.merge({exp: 30.days.from_now.to_i, jti: jti}), 
            ENV['JWT_SECRET'], 
            'HS256'
        )
    end

    def auth_header
        request.headers['Authorization']
    end

    def decoded_token
        if auth_header
            token = auth_header.split(' ')[1]

            begin
                token = JWT.decode(token, ENV['JWT_SECRET'], 'HS256').first
                item = DeniedJti.find_by(jti: token['jti']) ? nil : token
            rescue JWT::DecodeError, JWT::ExpiredSignature
                nil
            end
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token['user_id']
            @user = User.find_by(id: user_id)
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
            message: "#{record.name} created #{record.created_at}"}, 
            status: :created
    end


end
