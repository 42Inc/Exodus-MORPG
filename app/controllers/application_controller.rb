class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include ServerHelper
  include SessionsHelper
  include GameHelper

  def initialize
    @bgcolor = "black"
    @controller = "Default"
    @page = "Default"
    @face = "Times New Roman"

    #link_name, link_controller, link_action
    @links_main_menu = []

    #link_name, link_controller, link_action
    @links_navigation_menu = []
    @game_configuration = []
    @location_configuration = []
    if (ServerConfig.first == nil)
      _s = ServerConfig.new(permit_registration: false, show_adm_menu: "layout")
      _s.save
    end
  end
end
