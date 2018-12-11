class GameController < ApplicationController
  def initialize
    super
    @controller = "Game"
    @page = "Default"
    #link_name, link_controller, link_action
    @links_main_menu = []
    #link_name, link_controller, link_action
    @links_navigation_menu = []
    @game_configuration = load_yml("game_config/game_configuration.yml")
  end

  def game
    @links_main_menu = ["Start", "game", "play",
                        "About Game", "game", "about"]
    @links_navigation_menu = ["Main", "server", "main"]
    @page = "Game"
  end

  def play
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "Play"
    println(@game_configuration)
  end

  def game_iframes
    if (params[:id] == "1")
      render '/game/game_configuration_list.html.erb'
    else
      render '/server/notfound'
    end
  end

  def about
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "About"
  end
end
