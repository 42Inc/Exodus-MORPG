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
      _s = ServerConfig.new(permit_registration: false, show_adm_menu: "layout", time_to_disconnect: "600")
      _s.save
    end

    if ServerConfig.first.show_adm_menu == nil
      ServerConfig.first.update_attribute(:show_adm_menu, "layout")
    end

    if ServerConfig.first.permit_registration == nil
      ServerConfig.first.update_attribute(:permit_registration, false)
    end

    if ServerConfig.first.time_to_disconnect == nil
      ServerConfig.first.update_attribute(:time_to_disconnect, "600")
    end
  end
end
