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
                          "Admin Console", "server", "admconsole"]
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

    def admconsole
      @links_navigation_menu = ["Main", "server", "main",
                                "Server", "server", "server"]
      @page = "Admin"
    end
end
