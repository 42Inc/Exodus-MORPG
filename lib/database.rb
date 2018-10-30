#!/usr/bin/ruby

class Database
  public
    def initialize()
      @pid = 0
      @login_base_file_name = "data/logins.dat"
      @login_base_lock_file_name = "data/logins.lock"
      @adm_command_file_name = "data/adm_command.dat"
      @adm_command_lock_file_name = "data/adm_command.lock"
    end

    def set_pid(pid)
      @pid = pid
    end

#  for admins. needed passord
    def user_del(login)
     nothing()
    end

    def user_add(login, hash_password)
      if (correct_user?(login))
        return false
      end
      lock(@login_base_lock_file_name)
      base = File.open(@login_base_file_name, "a")
      base.puts login
      base.close
      unlock(@login_base_lock_file_name)
      return true
    end

    def send_adm_command(command)
      lock(@adm_command_lock_file_name)
      base = File.open(@adm_command_file_name, "w")
      base.puts command.to_s
      base.close
      unlock(@adm_command_lock_file_name)
    end

    def get_adm_command()
      lock(@adm_command_lock_file_name)
      base = File.open(@adm_command_file_name, "r")
      command = base.gets
      base.close
      unlock(@adm_command_lock_file_name)
      return command.chomp!
    end

    def correct_user?(login)
      lock(@login_base_lock_file_name)
      base = File.open(@login_base_file_name, "r")
      local_login = ""
      while (local_login = base.gets)
        if (local_login.chomp! == login)
           base.close
           unlock(@login_base_lock_file_name)
           return true
         end
      end
      base.close
      unlock(@login_base_lock_file_name)
      return false
    end
  private
#  lock file. Semaphor?
    def wait_unlock(file)
      while (1)
        @login_base_lock_file = File.open(file, "r")
        break if (@login_base_lock_file.gets.to_i == 0)
        @login_base_lock_file.close
      end
    end

    def lock(file)
        wait_unlock(file)
        @login_base_lock_file = File.open(file, "w")
        @login_base_lock_file.puts @pid.to_s
        @login_base_lock_file.close
    end

    def unlock(file)
        @login_base_lock_file = File.open(file, "w")
        @login_base_lock_file.puts "0"
        @login_base_lock_file.close
    end
end
