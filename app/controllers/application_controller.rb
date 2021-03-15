class ApplicationController < ActionController::API
    before_action :authorized 

    def encode_token(payload)
        # TODO: CHANGE TO AN ENV REF IMMEDIATELY
        JWT.encode(payload, 'MYSECRET')
    end
end
