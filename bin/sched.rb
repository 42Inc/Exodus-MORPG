#!/usr/bin/env ruby

require_relative "../lib/functions.rb"

def task_check_time_to_disconnect
  system("echo \"User.ids.each_with_index do |value, index| if (User.find_by(id: value).active == true) then if (Time.now.to_i - User.find_by(id: value).login_time.to_i > ServerConfig.first.time_to_disconnect.to_i) then User.find_by(id: value).update_attribute(:active, false) end end end \" | ./bin/rails c")
  sleep 60
end

while true
  task_check_time_to_disconnect
end
