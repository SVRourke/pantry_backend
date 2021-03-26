require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  def self.prepare
    # create a list add contributors and items
    @list = List.create(name: "Testing List")
    @list.contributors.push(User.create(name: "test1", email: "123@123.com", password: "password"))
    @list.contributors.push(User.create(name: "test2", email: "4556@456.com", password: "password"))
    byebug
  end

  def teardown
    @list.contributors.destroy_all
    @list.destroy
  end

  test 'show returns a list' do 
    get list_path(@list.id)
  end
  # show returns a list's contributors
  # show returns a lis's items
end
