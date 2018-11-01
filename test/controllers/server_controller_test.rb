require 'test_helper'

class ServerControllerTest < ActionDispatch::IntegrationTest
  test "should get info" do
    get server_info_url
    assert_response :success
  end

end
