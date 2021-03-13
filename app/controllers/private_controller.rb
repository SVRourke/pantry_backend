class PrivateController < ApplicationController
  def test
    render json: {
      message: "This is a private message for #{current_user.email}"
    }
  end
end
