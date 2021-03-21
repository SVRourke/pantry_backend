require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @good_user = User.new(name: 'sam', email: 's@s.com', password: 'pass')
    @email_user = User.new(name: 'sam', password: 'pass')
    @password_user = User.new(name: 'sam', email: 's@s.com')
  end
  
  test "user can be created" do
    assert @good_user.valid?, "Valid User does not save"
  end

  test "user invalid without email" do
    assert_not @email_user.valid?, "Able to save User without email"
  end

  test "user invalid without password" do
    assert_not @password_user.valid?, "Able to save user without password"
  end

  # A user has_many
  

end
