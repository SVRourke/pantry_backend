require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest  
  
  def self.prepare
    post users_path, params: {
      user: {
        email: 'gooder@login.com',
        name: 'good',
        password: 'password'}
      }, 
      as: :json

      @user_params_1 = {
        user: {
          email: '1234@login.com',
          name: 'good',
          password: 'password'
          }
        }


    @auth_header = "Bearer #{JSON.parse(@response.body)['JWY']}"
  end

  test 'does not create an invalid user' do
    post users_path, params: { 
      user: { 
        email: "geralt@rivia.com", 
        password: "yenniffer"} 
      }, as: :json
    
      assert_response :unprocessable_entity
  end

  test 'can create a valid user' do
    post users_path, params: {
      user: {
        email: 'good@login.com',
        name: 'good',
        password: 'password'}
      }, as: :json
    
      assert_response :created
  end

  test 'authenticates user on creation' do
    post users_path, params: {
      user: {
        email: 'good@login2.com',
        name: 'good',
        password: 'password'}
      }, as: :json
    
      body = JSON.parse(@response.body)

    assert body['jwt'], "Created User not authenticated"
  end

  test 'does not allow duplicate user creation' do
    params = {
      user: {
        email: 'good@login.com',
        name: 'good',
        password: 'password'}}

    User.create(params[:user])
    post users_path, params: params, as: :json

    assert_response :unprocessable_entity
  end

  test 'show is protected by auth' do
    get user_path(id: 600)
    assert_response :unauthorized
  end

  test 'show will show the logged in user' do
    post users_path, params: @user_params_1, as: :json
    
    body = JSON.parse(@response.body)

    get user_path(id: body['user']['id']), 
      headers: { Authorization: "Bearer #{body['jwt']}" }
    
      assert_response :ok
  end

  test 'show will only show the logged in user' do
    user = User.create(email: "s@s.com", name: "s", password: "password")

    get user_path(id: 600), 
      headers: { Authorization: @auth_header }

    assert_response :unauthorized
  end
end