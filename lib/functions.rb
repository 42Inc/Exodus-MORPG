#!/usr/bin/ruby
require 'yaml'

def println(string)
  STDOUT.print("#{string}\n")
end

def nothing()
  return 0
end

def set_color(obj, color)
  if (color == "debug")
    obj.print "\033[01;36m"
  elsif (color == "error")
    obj.print "\033[01;31m"
  elsif (color == "system")
    obj.print "\033[01;33m"
  elsif (color == "wrong")
    obj.print "\033[01;31m"
  elsif (color == "default")
    obj.print "\033[00m"
  end
end

def load_yml(filename)
  _file = YAML.load_file(filename)
  return _file
end
