require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get aboutgame" do
    get game_aboutgame_url
    assert_response :success
  end

end
