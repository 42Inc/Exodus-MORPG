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
    @user = current_user
    if (@user != nil)
      @player = Player.find_by(id_user: @user.id)
      @location = @player.location
      if @location == nil
        @player.update_attributes(location: "Goddard")
        @player.save
      end
      if @player.hp == nil
        @player.update_attributes(hp: "100")
        @player.save
      end
      if @player.money == nil
        @player.update_attributes(money: "1000")
        @player.save
      end

      @game_configuration = load_yml("game_config/game_configuration.yml")

      if @game_configuration[0]["locations"].include?(@location)
        @location_configuration = load_yml("game_config/locations/#{@location}.yml")
      else
        @location_configuration = nil
      end 
    else 
      @location_configuration = nil
    end
  end

  def game_iframes_1
    if (params[:id] == "0")
      @game_configuration = load_yml("game_config/game_configuration.yml")
      render '/game/game_configuration_list.html.erb'
    elsif (params[:id] == "1")
      @user = current_user
      if (@user != nil)
        @player = Player.find_by(id_user: @user.id)
        @location = @player.location
        if @location == nil
          @player.update_attributes(location: "Goddard")
          @player.save
          @location = @player.location
        end
        @game_configuration = load_yml("game_config/game_configuration.yml")
        if @game_configuration[0]["locations"].include?(@location)
          @location_configuration = load_yml("game_config/locations/#{@location}.yml")
        else
          @location_configuration = nil
        end 

        if (@location_configuration != nil)
          render '/game/game_location_view.html.erb'
        else 
          render '/game/game_configuration_list.html.erb'
        end
      end
    end
  end

  def game_iframes_3
    @user = current_user
    if (@user != nil)
      @player = Player.find_by(id_user: @user.id)
      @location = @player.location
      if @location == nil
        @player.update_attributes(location: "Goddard")
        @player.save
        @location = @player.location
      end
      @game_configuration = load_yml("game_config/game_configuration.yml")
      if @game_configuration[0]["locations"].include?(@location)
        @location_configuration = load_yml("game_config/locations/#{@location}.yml")
      else
        @location_configuration = nil
      end 
    end
    render '/game/game_location_users_list.html.erb'
  end

  def game_posts
    if (params[:id] == "0")
      AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "nothing")  
    elsif (params[:id] == "1")
      if (params[:commit] != nil)
        @user = current_user
        if (@user != nil)
          @player = Player.find_by(id_user: @user.id)
          @player.update_attributes(location: params[:commit])
          @player.save
        end
        AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "location")    
      end        
    elsif (params[:id] == "2")
      if (params[:commit] != nil)
        @quest_config = load_yml("game_config/quests/#{params[:commit]}.yml")
        @user = current_user
        if (@user != nil)
          @quest = Quest.find_by(id_quest: @quest_config[0]["questId"], id_user: @user.id)
          if (@quest == nil)
            @quest = Quest.new(id_user: @user.id, stage: "1", id_quest: @quest_config[0]["questId"][0], name_quest: params[:commit], type_quest: @quest_config[0]["type_quest"][0], target: @quest_config[0]["target"][0], count: @quest_config[0]["count"][0]);
            @quest.save
          end
        end  
      end
    elsif (params[:id] == "3") 
      if (params[:commit] != nil)
        @quest = Quest.find_by(target: params[:commit], id_user: current_user.id, type_quest: "kill")
        if (@quest != nil)
          if (@quest.count.to_i > 0)
            @quest.update_attributes(count: (@quest.count.to_i - 1))
          else
            @quest.update_attributes(stage: "255")
          end
        end  
      end
    end
    redirect_to '/game/play'
  end

  def about
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "About"
  end
end
