#!/usr/bin/ruby
require 'socket'
require_relative "functions.rb"
require_relative "database.rb"
require_relative "adm_console.rb"

class ServerEngine
  public
    def initialize()
      @readline_socket = Queue.new
      @semaphore = Mutex.new
      @Database = Database.new
      @AdmConsole = AdmConsole.new
      @adm_command = -1
      @command_complete = 0

      @Database.send_adm_command(@adm_command)
    end

    def run_server(server_ip, server_port_read, server_port_write)
      @server_socket_write = TCPServer.new(server_ip, server_port_write)
      @server_socket_read = TCPServer.new(server_ip, server_port_read)
      println("[Started] Server, ip is #{server_ip} , read port - #{server_port_read}")
      println("[Started] Server, ip is #{server_ip} , write port - #{server_port_write}")
      create_wait_clients_thread()
      while (1)
        @adm_command = @AdmConsole.adm_get_command()
        @Database.send_adm_command(@adm_command)
        break if (@adm_command == 0)
      end
      @Thread_wait_clients_id.exit
    end

  private
    def wait_clients()
      @client_write = @server_socket_write.accept
      @client_read = @server_socket_read.accept
      println("[Connected] Client, ip is #{@client_write.peeraddr[2]} -> #{@client_write.addr[2]}, port - #{@client_write.peeraddr[1]} -> #{@client_write.addr[1]}")
      println("[Connected] Client, ip is #{@client_read.peeraddr[2]} -> #{@client_read.addr[2]}, port - #{@client_read.peeraddr[1]} -> #{@client_read.addr[1]}")
      @fork_id_client = Process.fork do
        @Database.set_pid(Process.pid)
        client()
      end
      Process.detach(@fork_id_client)
    end

    def get_readline_socket()
      @semaphore.lock
      if (@readline_socket.empty?)
        var = ""
      else
        var = @readline_socket.pop
      end
      @semaphore.unlock
      return var
    end

    def set_readline_socket(var)
      @semaphore.lock
      @readline_socket.push(var)
      @semaphore.unlock
    end

    def client()
      create_reader_thread()
      send_to_client("Hello, Your ip is #{@client_write.peeraddr[2]} -> #{@client_write.addr[2]},read port - #{@client_write.peeraddr[1]} -> #{@client_write.addr[1]}")
      send_to_client("Hello, Your ip is #{@client_read.peeraddr[2]} -> #{@client_read.addr[2]},write port - #{@client_read.peeraddr[1]} -> #{@client_read.addr[1]}")
      send_to_client("Enter sign in/upor disconnect [in / up / disc]: ")
      loop do
        var = 0
        admin_command = @Database.get_adm_command()
        case (admin_command.to_i)
          when 0
            shutdown()
            return
          else
            nothing()
        end
        line = get_readline_socket()
        if (line.nil? || line == "")
          line = ""
          var = 0
        elsif (line == "up")
          line = ""
          var = 1
        elsif (line == "in")
          line = ""
          var = 2
        elsif (line.downcase == "disc")
          line = ""
          break
        else
          var = -1
        end
        case (var)
          when 0
            nothing()
          when 1
            com = sign_up()
            if (com == 0)
              shutdown()
              return
            end
          when 2
            com = sign_in()
            if (com == 0)
              shutdown()
              return
            end
          else
            reply_err("Enter sign in/up or disconnect [in / up / disc]: ")
        end
      end

      disconnect_client()
      @client_write.close
      @client_write = -1
      @Thread_readsocket_id.join
      @client_read.close
      @readline_socket.close
      @client_read = -1
    end

    def shutdown()
      disconnect_client()
      @Thread_readsocket_id.exit
      @client_write.close
      @client_read.close
      @readline_socket.close
    end

    def reply_err(str = "")
      send_to_client("[Wrong data] #{str}")
    end

    def send_to_client(str = "")
      @client_write.puts(str)
    end

    def sign_in()
      send_to_client("Enter your login, please:")
      login = ""
      loop do
        login = ""
        admin_command = @Database.get_adm_command()
        case (admin_command.to_i)
          when 0
            return 0
          else
            nothing()
        end
        login = get_readline_socket()
        if (login == "-")
          send_to_client("[Exit] Enter sign in/up or disconnect [in / up / disc]: ")
          return
        elsif (login.nil? || login == "")
          nothing()
        else
          if (@Database.correct_user?(login))
            break
          else
            println("[Failed login] Client login - '#{login}', ip is #{@client_read.peeraddr[2]} failed login")
            send_to_client("[Wrong login] Repeat, please:")
          end
        end
      end

      println("[Success login] Client login - '#{login}', ip is #{@client_read.peeraddr[2]} success login")
      send_to_client("[Success login] Enter sign in/up or disconnect [in / up / disc]: ")
      return -1
    end

    def sign_up()
      send_to_client("Enter your login, please:")
      login = ""
      loop do
        login = ""
        admin_command = @Database.get_adm_command()
        case (admin_command.to_i)
          when 0
            return 0
          else
            nothing()
        end
        login = get_readline_socket()
        if (login == "-")
          send_to_client("[Exit] Enter sign in/up or disconnect [in / up / disc]: ")
          return
        end
        if (login.nil? || login == "")
          nothing()
        else
          if (@Database.user_add(login, 0))
            break
          else
            send_to_client("[Wrong login] Repeat, please:")
          end
        end
      end
      println("[Success registration] Client login - '#{login}', ip is #{@client_read.peeraddr[2]} success registred")
      send_to_client("[Success registration] Enter sign in/up or disconnect [in / up / disc]: ")
      return -1
    end

    def create_wait_clients_thread()
      @Thread_wait_clients_id = Thread.new do
        while (1)
          wait_clients()
        end
      end
    end

    def create_reader_thread()
      @Thread_readsocket_id = Thread.new do
        readline_sock = ""
        while (1)
          readline_sock = @client_read.gets.chomp!
          set_readline_socket(readline_sock)
          break if (readline_sock == "disc")
          readline_sock = ""
        end
      end
    end

    def disconnect_client()
      println("[Disconnected] Client, ip is #{@client_write.peeraddr[2]}, port - #{@client_write.peeraddr[1]} -> #{@client_write.addr[1]} are disconnected")
      println("[Disconnected] Client, ip is #{@client_read.peeraddr[2]}, port - #{@client_read.peeraddr[1]} -> #{@client_read.addr[1]} are disconnected")
      send_to_client("disc")
    end
end


Engine = ServerEngine.new
Engine.run_server('127.0.0.1', 65501, 65502)
