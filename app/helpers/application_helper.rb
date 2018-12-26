require_relative '../../lib/functions.rb'

$permit_registration = false
$show_adm_menu = "layout"

module ApplicationHelper
  def get_git_branch
    system "git branch 2>/dev/null | sed -n '/^\\*/s/^\\* //p' > gitbranch.dat"
    file = open "gitbranch.dat"
    _current_branch = file.gets
    file.close
    return _current_branch
  end
end
