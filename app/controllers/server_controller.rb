class ServerController < ApplicationController
  public
    def initialize
      @controller = "Server"
      @page = "Default"
    end
    
    def info
      @page = "Info"
    end

    def mainpage
      @page = "Main"
    end

    def admconsole
      @page = "Admin"
      @r_ip = request.remote_ip
      @r_port = request.port
    end
end
