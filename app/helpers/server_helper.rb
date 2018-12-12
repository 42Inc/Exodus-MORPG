module ServerHelper
  def get_admin_iframe_1
    _path = "/server/admin/iframes_1/"
    if ($view_list_1 == "nothing")
      return _path + "0"
    elsif ($view_list_1 == "users_list")
      return _path + "1"
    elsif ($view_list_1 == "game_conf")
      return _path + "2"
    elsif ($view_list_1 == "user")
      return _path + "3"
    elsif ($view_list_1 == "location")
      return _path + "4"
    else
      return _path + "0"
    end      
  end

  def get_admin_iframe_2
    _path = "/server/admin/iframes_2/0"
    return _path
  end

  def get_admin_iframe_3
    _path = "/server/admin/iframes_3/0"
    return _path
  end
end
