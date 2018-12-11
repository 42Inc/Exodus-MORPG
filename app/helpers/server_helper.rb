module ServerHelper
  def get_admin_iframe
    path = "/server/admin/iframes/"
    if ($view_list == "nothing")
      return path + "0"
    elsif ($view_list == "users_list")
      return path + "1"
    elsif ($view_list == "game_conf")
      return path + "2"
    elsif ($view_list == "user")
      return path + "3"
    else
      return path + "0"
    end      
  end
end
