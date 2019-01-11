module GameHelper
  def get_game_iframe_1
    _path = "/game/play/iframes_1/"
    if (AdmViewDatum.find_by(id_user: current_user.id).view_list_game_iframe_1 == "nothing")
      return _path + "0"
    elsif (AdmViewDatum.find_by(id_user: current_user.id).view_list_game_iframe_1 == "location")
      return _path + "1"
    else
      return _path + "0"
    end      
  end
end
