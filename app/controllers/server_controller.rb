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

    def admin_iframes
      if (params[:id] == "0")
        render '/layouts/nothing.html.erb'
      elsif (params[:id] == "1")
        render '/server/admin_users_list.html.erb'
      elsif (params[:id] == "2")
        @game_configuration = load_yml("game_config/game_configuration.yml")
        render '/game/game_configuration_list.html.erb'
      elsif (params[:id] == "3")
        render '/server/admin_user_view.html.erb'
      else
        render '/server/notfound'
      end
    end

    def admin_posts
      if (params[:id] == "0")
        $view_list = "nothing"
      elsif (params[:id] == "1")
        $view_list = "users_list"
      elsif (params[:id] == "2")
        $view_list = "game_conf"
      elsif (params[:id] == "3")
        if $view_list == "users_list" || $view_list == "user"
          $view_user_id = params[:val]
          $view_list = "user"
        elsif $view_list == "game_conf" || $view_list == "location"
          $view_location = params[:val]
          $view_list = "location"
        else
          $view_list = "nothing"
        end
      elsif (params[:id] == "4")
        $permit_registration = $permit_registration == true ? false : true
      else 
        $view_list = "nothing"
        $view_location = "nothing"
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
