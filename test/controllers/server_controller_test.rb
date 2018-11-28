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
    get '/server/admin'
    assert_redirected_to '/server/notfound'
  end

  test "should get 404 [0]" do
    get '/server/notfound'
    assert_response :success
    assert_select "title", "Server : 404"
  end

  test "should get 404 [1]" do
    get '/invalid-path'
    assert_response :success
    assert_select "title", "Server : 404"
  end

  test "should get 404 [2]" do
    get '/invalid/path'
    assert_response :success
    assert_select "title", "Server : 404"
  end

  test "should get 404 [3]" do
    get '/server/invalid'
    assert_response :success
    assert_select "title", "Server : 404"
  end

end
