class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include ApplicationHelper
  include ServerHelper
  include SessionsHelper

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
  end
end
