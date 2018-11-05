class ApplicationController < ActionController::Base
  def initialize
    @bgcolor = "black"
    @controller = "Default"
    @page = "Default"
    #link_name, link_controller, link_action
    @links_main_menu = []
    #link_name, link_controller, link_action
    @links_navigation_menu = []
  end
end
