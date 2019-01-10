require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  
  test "should get about" do
    get '/game/about'
    assert_response :success
    assert_select "title", "Game : About"
  end

  test "should get play" do
    get '/game/play'
    assert_response :success
    assert_select "title", "Game : Play"
  end

end
