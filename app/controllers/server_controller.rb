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
    end

    def server
      @links_main_menu = ["Server Info", "server", "info",
                          "Admin", "server", "admin"]
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
    end

    def create
      @links_navigation_menu = ["Main", "server", "main",
                                "Server", "server", "server"]
      @page = "Admin"
      user = User.find_by(email: params[:session][:email].downcase)

      if user && user.authenticate(params[:session][:password]) && user.adm == true
        log_in user
        if params[:session][:remember_me] == '1'
          remember(user)
        end
        redirect_to '/server/admin'
      else
        if (user && user.name != "")
          flash.now[:danger] = "Invalid email/password combination or user #{user.name} is not admin"
        else
          flash.now[:danger] = "Invalid email/password combination"
        end
        render 'admin'
      end
    end

end
