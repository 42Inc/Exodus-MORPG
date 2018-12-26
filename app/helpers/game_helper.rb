module GameHelper
  def get_game_iframe_1
    _path = "/game/play/iframes_1/"
    if ($view_list_game_iframe_1 == "nothing")
      return _path + "0"
    elsif ($view_list_game_iframe_1 == "location")
      return _path + "1"
    else
      return _path + "0"
    end      
  end
end
