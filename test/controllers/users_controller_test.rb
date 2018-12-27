require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get '/users/new'
    assert_response :success
    assert_select "title", "Users : New"
  end

  test "should get index" do
    get users_path
    assert_response :success
    assert_select "title", "Users : Index"
  end

end
