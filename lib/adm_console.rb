#!/usr/bin/ruby

class AdmConsole
  public
    def initialize
      @command = ""
      @command_index = -1
    end

    def adm_get_command()
      while (1)
        @command = STDIN.gets.chomp!
        println ("[Admin Command] #{@command}")
        adm_command_handler()
        break if (@command_index != -1)
      end
      return @command_index
    end

  private
    def adm_command_handler
      case (@command)
        when "shutdown"
          @command_index = 0
        else
          @command_index = -1
      end
    end
end
