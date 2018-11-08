require 'test_helper'

class ServerControllerTest < ActionDispatch::IntegrationTest
  test "should get server" do
    get '/server'
    assert_response :success
    assert_select "title", "Server : Server"
  end

  test "should get info" do
    get '/server/info'
    assert_response :success
    assert_select "title", "Server : Info"
  end

  test "should get main" do
    get '/'
    assert_response :success
    assert_select "title", "Server : Main"
  end

  test "should get admin" do
    get '/server/admconsole'
    assert_response :success
    assert_select "title", "Server : Admin"
  end

end
