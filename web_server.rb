require 'socket'
require 'lib/config/configuration'
require 'lib/logger'
require 'lib/error'
require 'lib/worker'

module WebServer
  class Server
    DEFAULT_PORT = 2468

    def initialize(options={})
      # Set up WebServer's configuration files and logger here
      # Do any preparation necessary to allow threading multiple requests
    end

    def start
      # Begin your 'infinite' loop, reading from the TCPServer, and
      # processing the requests as connections are made
    end

    private
  end
end

WebServer::Server.new.start
