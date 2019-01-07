class ServerController < ApplicationController
  layout "application"
  public
    def initialize
      super
      @controller = "Server"
      @page = "Default"
      #link_name, link_controller, link_action
      @links_main_menu = []
      #link_name, link_controller, link_action
      @links_navigation_menu = []
      @view_user_id = 0
    end

    def server
      @links_main_menu = ["Server Info", "server", "info"]
      @links_navigation_menu = ["Main", "server", "main"]
      @page = "Server"
    end

    def info
      @links_navigation_menu = ["Main", "server", "main",
                                "Server", "server", "server"]
      @page = "Info"
    end

    def main
      @links_main_menu = ["Server", "server", "server",
                          "Game", "game", "game",
                          "Users", "users", "index"]
      @links_navigation_menu = []
      @page = "Main"

      if logged_in?
        @adm = AdmViewDatum.find_by(id_user: current_user.id)
        if @adm == nil
          @adm = AdmViewDatum.new
          @adm.id_user = current_user.id
          @adm.view_list_adm_iframe_1 = "nothing"
          @adm.view_location = "nothing"
          @adm.view_location_iframe = "nothing"
          @adm.view_user_adm_iframe_id_1 = "0"
          @adm.view_list_game_iframe_1 = "location"
          @adm.save
        end

        @player = Player.find_by(id_user: current_user.id)
        if @player == nil
          @player = Player.new(id_user: current_user.id, name_user: current_user.name)
          @player.save
        end
      end
    end

    def admin
      @links_navigation_menu = ["Main", "server", "main",
                                "Server", "server", "server"]
      @page = "Admin"
      if logged_in?
        if current_user.adm == false
          redirect_to '/server/notfound'
        end
      elsif
        redirect_to '/server/notfound'
      end
    end

    def admin_iframes_1
      if (params[:id] == "0")
        render '/layouts/nothing.html.erb'
      elsif (params[:id] == "1")
        render '/server/admin_users_list.html.erb'
      elsif (params[:id] == "2")
        @game_configuration = load_yml("game_config/game_configuration.yml")
        render '/game/game_configuration_list.html.erb'
      elsif (params[:id] == "3")
        render '/server/admin_user_view.html.erb'
      elsif (params[:id] == "4")
        @game_configuration = load_yml("game_config/game_configuration.yml")
        if @game_configuration[0]["locations"].include?(AdmViewDatum.find_by(id_user: current_user.id).view_location_iframe)
          @location_configuration = load_yml("game_config/locations/#{AdmViewDatum.find_by(id_user: current_user.id).view_location_iframe}.yml")
        else
          @location_configuration = nil
        end 
        render '/game/game_location_view.html.erb'     
      else
        render '/server/notfound'
      end
    end

    def admin_iframes_2
      if (params[:id] == "0")
        render '/layouts/nothing.html.erb'
      else
        render '/server/notfound'
      end
    end

    def admin_iframes_3
      if (params[:id] == "0")
        render '/server/admin_info.html.erb'
      else
        render '/server/notfound'
      end
    end

    def admin_posts
      case params[:id]
        when "0"
          AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "nothing")
        when "1"
          AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "users_list")
        when "2"
          AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "game_conf")
        when "3"
          if AdmViewDatum.find_by(id_user: current_user.id).view_list_adm_iframe_1 == "users_list" || AdmViewDatum.find_by(id_user: current_user.id).view_list == "user"
            AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_user_adm_iframe_id_1: params[:val])
            AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "user")
          elsif AdmViewDatum.find_by(id_user: current_user.id).view_list_adm_iframe_1 == "game_conf" || AdmViewDatum.find_by(id_user: current_user.id).view_list == "location"
            AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_location_iframe: params[:val])
            AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "location")
          else
            AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "nothing")
          end
        when "4"
          $permit_registration = $permit_registration == true ? false : true
        when "5"
          case $show_adm_menu
            when "layout"
              $show_adm_menu = "default"
            when "none"
              $show_adm_menu = "layout"
            when "default"
              $show_adm_menu = "none"
            else
              $show_adm_menu = "none"
          end
        else 
          AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_list_adm_iframe_1: "nothing")
          AdmViewDatum.find_by(id_user: current_user.id).update_attributes(view_location_iframe: "nothing")
      end
      redirect_to '/server/admin'
    end

    def notfound
      @links_navigation_menu = ["Main", "server", "main",
                                "Server", "server", "server"]
      @page = "404"
      rescue ActiveRecord::RecordNotFound
      render 404
    end

end
