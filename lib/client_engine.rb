#!/usr/bin/ruby
require 'socket'
require_relative "functions.rb"

class ClientEngine
  public
    def initialize()
      @ackline = ""
      @readline_stdin = Queue.new
      @readline_socket = Queue.new
      @semaphore_socket = Mutex.new
      @semaphore_stdin = Mutex.new
    end

    def connect(server_ip, server_port_write, server_port_read, source_port)
      @client_socket_read = TCPSocket.new(server_ip, server_port_read, '127.0.0.1', source_port)
      @client_socket_write = TCPSocket.new(server_ip, server_port_write, '127.0.0.1', source_port + 1)

      create_reader_socket_thread()
      create_reader_stdin_thread()
      loop do
        readline_stdin = get_readline_stdin();
        readline_socket = get_readline_socket();
        break if (readline_socket == "disc")
        if (!readline_stdin.nil? && readline_stdin != "")
          @client_socket_write.puts readline_stdin
        end
      end
      println("[Disconnected]")
      @client_socket_write.close
      @client_socket_write == -1
      @Thread_read_socket_id.exit
      @Thread_read_stdin_id.exit
      @client_socket_read.close
      @readline_socket.close
      @readline_stdin.close
      @client_socket_read == -1
    end
  private

    def get_readline_stdin()
      @semaphore_stdin.lock
      if (@readline_stdin.empty?)
        var = ""
      else
        var = @readline_stdin.pop
      end
      @semaphore_stdin.unlock
      return var
    end

    def set_readline_stdin(var)
      @semaphore_stdin.lock
      @readline_stdin.push(var)
      @semaphore_stdin.unlock
    end

    def get_readline_socket()
      @semaphore_socket.lock
      if (@readline_socket.empty?)
        var = ""
      else
        var = @readline_socket.pop
      end
      @semaphore_socket.unlock
      return var
    end

    def set_readline_socket(var)
      @semaphore_socket.lock
      @readline_socket.push(var)
      @semaphore_socket.unlock
    end

    def create_reader_socket_thread()
      @Thread_read_socket_id = Thread.new do
        readline_sock = ""
        while (1)
          readline_sock = @client_socket_read.gets.chomp!
          set_readline_socket(readline_sock)
          break if (readline_sock == "disc")
          println(readline_sock)
          readline_sock = ""
        end
      end
    end

    def create_reader_stdin_thread()
      @Thread_read_stdin_id = Thread.new do
        readline_stdin = ""
        while (1)
          readline_stdin = STDIN.gets.chomp!
          set_readline_stdin(readline_stdin)
        end
      end
    end
end

Engine = ClientEngine.new
Engine.connect('127.0.0.1', 65501, 65502, ARGV.length > 0 ? ARGV[0].to_i : 65503)
