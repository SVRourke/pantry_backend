require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @good_user = User.create(name: 'sam', email: 's@s.com', password: 'pass')
    @email_user = User.new(name: 'sam', password: 'pass')
    @password_user = User.new(name: 'sam', email: 's@s.com')

    @lists = [
      List.create(name: "list one"),
      List.create(name: "list two"),
      List.create(name: "list three")
    ]
    @lists.each { |l| l.contributors.push(@good_user) }

    @users = [
      User.new(name: "a", email: "1A@b.c", password: "passsword"),
      User.new(name: "b", email: "2A@b.c", password: "passsword"),
      User.new(name: "c", email: "3A@b.c", password: "passsword")
    ]

    @users.each {|u| @good_user.friends.push(u)}


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

  test "user can have multiple lists" do
    
    assert @good_user.lists.count > 1, "list relationship needs to be two ways"
  end

  test "user can leave a list" do
    @good_user.leave_list(@lists.first)
    assert @good_user.lists.count < 3, "issue with #leave_list"
  end

  test "user can have many friends" do
    assert @good_user.friends.count > 1
  end

  test "user can remove a friend" do
    @good_user.unfriend(@users.first)
    assert @good_user.friends.count < 3
  end

end