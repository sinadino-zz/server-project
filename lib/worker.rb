require_relative '../lib/request'
require_relative '../lib/response'
require_relative '../lib/logger'


# This class will be executed in the context of a thread, and
# should instantiate a Request from the client (socket), perform
# any logging, and issue the Response to the client.
module WebServer
  class Worker
    # Takes a reference to the client socket and the logger object
    attr_accessor :request, :response, :logger, :client

    def initialize(client, server)
      @client = client
      @request = WebServer::Request.new client
      @logger = logger
      @request.to_s
      #added by john but not used
      @server = WebServer::Request.new server
      
    end
     

    # Processes the request
    def process_request
      #@request 
      @client.close
    end
  end
end

