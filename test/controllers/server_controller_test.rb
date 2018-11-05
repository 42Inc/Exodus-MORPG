require 'test_helper'

class ServerControllerTest < ActionDispatch::IntegrationTest
  test "should get server" do
    get server_url
    assert_response :success
    assert_select "title", "Server : Server"
  end

  test "should get info" do
    get server_info_url
    assert_response :success
    assert_select "title", "Server : Info"
  end

  test "should get main" do
    get root_url
    assert_response :success
    assert_select "title", "Server : Main"
  end

  test "should get admconsole" do
    get server_admconsole_url
    assert_response :success
    assert_select "title", "Server : Admin"
  end

end
