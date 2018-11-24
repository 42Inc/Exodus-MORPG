require 'test_helper'

class GameControllerTest < ActionDispatch::IntegrationTest
  test "should get about" do
    get '/game/about'
    assert_response :success
    assert_select "title", "Game : About"
  end

  test "should get gameprocess" do
    get '/game/gameprocess'
    assert_response :success
    assert_select "title", "Game : Gameprocess"
  end

end
