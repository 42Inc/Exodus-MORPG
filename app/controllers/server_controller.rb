class ServerController < ApplicationController
  public
    def initialize
      @controller = "Server"
      @page = "Default"
    end

    def server
      @page = "Server"
    end

    def info
      @page = "Info"
    end

    def aboutgame
      @page = "About"
    end

    def mainpage
      @page = "Main"
    end

    def admconsole
      @page = "Admin"
    end
end
