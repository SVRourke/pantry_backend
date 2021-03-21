require "test_helper"

class AuthControllerTest < ActionDispatch::IntegrationTest
  def setup
    @bad_login = { 
      user: { 
        email: "geralt@rivia.com", 
        password: "yenniffer" 
      } 
    }
    @good_login = {
      user: {
        email: 'good@login.com',
        name: 'good',
        password: 'password'
      }
    }
    User.create(@good_login[:user])
  end


  test "does not issue a JWT with incorrect login" do
    post login_path, params: @bad_login, as: :json
    assert_response :unauthorized
  end
  
  test "response ok with proper credentials" do
    post login_path, params: @good_login, as: :json
    assert_response :created, "Wrong response Code"
  end
  
  test "issue a JWT with proper credentials" do
    post login_path, params: @good_login, as: :json
    body = JSON.parse(@response.body)
    assert body['jwt'], "No JWT ISSUED"
  end

  # invalidates a JWT on destroy
end
