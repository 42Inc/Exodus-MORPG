module ServerHelper
  $view_list = "nothing"
  def get_admin_iframe
    path = "/server/admin/iframes/"
    if ($view_list == "nothing")
      return path + "0"
    elsif ($view_list == "users_list")
      return path + "1"
    elsif ($view_list == "game_conf")
      return path + "2"
    else
      return path + "0"
    end      
  end
end
