require_relative '../../lib/functions.rb'

$permit_registration = false
$view_list_1 = "nothing"
$view_user_id_1 = 0
$view_location_1 = "nothing"

module ApplicationHelper
  def get_git_branch
    system "git branch 2>/dev/null | sed -n '/^\\*/s/^\\* //p' > gitbranch.dat"
    file = open "gitbranch.dat"
    _current_branch = file.gets
    file.close
    return _current_branch
  end
end
