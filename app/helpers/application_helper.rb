require_relative '../../lib/functions.rb'

$permit_registration = false
$view_list_adm_iframe_1 = "nothing"
$view_user_adm_iframe_id_1 = 0
$view_location = "nothing"
$show_adm_menu = "layout"
$view_list_game_iframe_1 = "location"

module ApplicationHelper
  def get_git_branch
    system "git branch 2>/dev/null | sed -n '/^\\*/s/^\\* //p' > gitbranch.dat"
    file = open "gitbranch.dat"
    _current_branch = file.gets
    file.close
    return _current_branch
  end
end
