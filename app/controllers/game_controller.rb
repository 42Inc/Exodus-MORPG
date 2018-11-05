class GameController < ApplicationController
  def initialize
    super
    @controller = "Game"
    @page = "Default"
    #link_name, link_controller, link_action
    @links_main_menu = []
    #link_name, link_controller, link_action
    @links_navigation_menu = []
  end

  def game
    @links_main_menu = ["About Game", "game", "about"]
    @links_navigation_menu = ["Main", "server", "main"]
    @page = "Game"
  end

  def about
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "About"
  end
end
