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
    @links_main_menu = ["Start", "game", "play",
                        "About Game", "game", "about"]
    @links_navigation_menu = ["Main", "server", "main"]
    @page = "Game"
  end

  def play
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "Play"
  end

  def game_iframes_1
    if (params[:id] == "0")
      @game_configuration = load_yml("game_config/game_configuration.yml")
      render '/game/game_configuration_list.html.erb'
    elsif (params[:id] == "1")
      @user = current_user
      @player = Player.find_by(id: @user.id)
      @location = @player.location
      if @location == nil
        @player.update_attributes(location: "Goddard")
        @player.save
        @location = @player.location
      end
      @location_configuration = load_yml("game_config/locations/#{@location}.yml")
      render '/game/game_location_view.html.erb'
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
