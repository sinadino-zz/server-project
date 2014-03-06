require 'socket'
require 'lib/config/httpd_conf'
require 'lib/response'
require 'lib/worker'

Dir.glob('lib/**/*.rb').each do |file|
 require file
end

module WebServer
  class Server

    attr_accessor :the_server, :server_config

    def initialize(options={})
      @options = options
      initServer
    end


    def start
      #on webserver::worker replace logger by self
      loop do
        puts "Opening server socket to listen on port #{@server_config.port}"
        Thread.start(@the_server.accept) do |client|
          @logger = WebServer::Logger.new(@server_config.log_file)
          worker = WebServer::Worker.new(client, self).
          worker.process_request
         
        end
      end

# added by octavian
# WebServer::Worker.new(client, 
# WebServer::Logger.new(@server_config.log_file)).process_request





    end

    def initServer
      conf_file = 'httpd.conf'
      directory = File.join File.dirname(__FILE__), 'config'
      options = { :conf_file => conf_file, :configuration_directory => directory}
      @server_config = WebServer::HttpdConf.new(options)

      @the_server ||= TCPServer.open(@server_config.port)
    end

  end
end

WebServer::Server.new.start
