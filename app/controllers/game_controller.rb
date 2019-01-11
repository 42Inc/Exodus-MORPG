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
      end
      if @player.hp == nil
        @player.update_attributes(hp: "100")
      end
      if @player.money == nil
        @player.update_attributes(money: "1000")
      end
      if @player.def == nil
        @player.update_attributes(def: "2")
      end
      if @player.immortality == nil
        @player.update_attributes(immortality: false)
      end

      @game_configuration = load_yml("game_config/game_configuration.yml")

      if @game_configuration[0]["locations"].include?(@location)
        @location_configuration = load_yml("game_config/locations/#{@location}.yml")
      else
        @location_configuration = nil
      end 
      if (@player.hp.to_i <= 0)
        redirect_to '/game/dead'
      end
    else 
      @location_configuration = nil
    end
  end

  def dead
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "Dead"
    if logged_in?
      if (Player.find_by(id_user: current_user.id).hp.to_i > 0)
        redirect_to '/game/play'
        return
      end
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
            @quest = Quest.new(id_user: @user.id, stage: "1", id_quest: @quest_config[0]["questId"][0], name_quest: params[:commit], type_quest: @quest_config[0]["type_quest"][0], target: @quest_config[0]["target"], count: @quest_config[0]["count"]);
            @quest.save
          elsif (@quest_config[0]["repeat"] != nil && @quest_config[0]["repeat"] == true)
            @quest.update_attributes(stage: "1", count: @quest_config[0]["count"]);
          end
          if (@quest.type_quest == "heal")
            complete_quest(Player.find_by(id_user: @user.id), @quest_config, @quest)
          end
        end  
      end
    elsif (params[:id] == "3") 
      if (params[:commit] != nil)
        @mob_config = load_yml("game_config/mobs/#{params[:commit]}.yml")
        _player = Player.find_by(id_user: current_user.id)
        change_hp(_player, "-#{@mob_config[0]["power"].to_i/(2 * _player.def.to_i)}")

        if (@mob_config[0]["deathchance"] != nil)
          _chance = @mob_config[0]["deathchance"].split("/")
          rand_num = (rand()*(1000))%(_chance[1].to_f - 1.0) + 1.0
          if (rand_num.to_f > _chance[0].to_f)
            redirect_to '/game/play'
            return
          end
        end

        Quest.find_each do |i|
          @quest = i 
          if (@quest != nil && @quest.id_user.to_i == current_user.id)
            @quest_config = load_yml("game_config/quests/#{@quest.name_quest}.yml")
            if (@quest.type_quest == "kill")
              _target_array = @quest.target.delete("[").delete("]").delete("\"").split(", ")
              _count_array =  @quest.count.delete("[").delete("]").delete("\"").split(", ")
              if (@quest.target.include?(params[:commit]) && (_target_array.length == _count_array.length))
                _index = _target_array.index(params[:commit])
                if (_index != nil)
                  if (_count_array[_index].to_i > 0)
                    _count_array[_index] = (_count_array[_index].to_i - 1).to_s
                    if (_count_array[_index] == "0")
                      @quest.update_attributes(stage: @quest.stage.to_i + 1)
                    end
                    @quest.update_attributes(count: _count_array)
                  end
                  if (_count_array.length == _count_array.count("0")) 
                    complete_quest(_player, @quest_config, @quest)
                    _player.update_attributes(money: _player.money.to_i + 2)
                  end
                end
              else
                nothing()
              end
            end
          end
        end  
      end
    elsif (params[:id] == "4") 
      _player = Player.find_by(id_user: current_user.id)
      _player.update_attributes(hp: 50)
      _money = _player.money.to_i - 100
      _money = _money < 0 ? 0 : _money
      _player.update_attributes(money: _money)
    end
    redirect_to '/game/play'
  end

  def about
    @links_navigation_menu = ["Main", "server", "main",
                              "Game", "game", "game"]
    @page = "About"
  end

  private
    def change_hp(obj, val)
      if (obj.immortality == false)
        _hp = (obj.hp.to_i + val.to_i)
        _hp = _hp < 0 ? 0 : (_hp > 100 ? 100 : _hp) 
        obj.update_attributes(hp: _hp)
      end
    end

    def complete_quest(player, config, quest)
      @quest.update_attributes(stage: "255")
      if (@quest_config[0]["complete"] != nil)
        @quest_config[0]["complete"].each_with_index do |val, index|
          if (val["money"] != nil)
            player.update_attributes(money: player.money.to_i + val["money"].to_i)
          end

          if (val["hp"] != nil)
            change_hp(player, val["hp"])
          end
        end
      end
    end
end
