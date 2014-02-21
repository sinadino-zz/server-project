# This class is a work in progress
module WebServer
  module Response
    DEFAULT_HTTP_VERSION = 'HTTP/1.1'


    RESPONSE_CODES = {
      200 => 'OK',
      201 => 'Successfully Created',
      304 => 'Not Modified',
      400 => 'Bad Request',
      401 => 'Unauthorized',
      403 => 'Forbidden',
      404 => 'Not Found',
      500 => 'Internal Server Error'
    }

      #trying to solve uninitialized constant WebServer::Response::Base 
    class Base 
      def initialize 
      end
    end
    
      
    def self.default_headers
      {
        'Date' => Time.now.strftime('%a, %e %b %Y %H:%M:%S %Z'),
        'Server' => 'John Roberts CSC 667'
      }
    end

    module Factory
      def self.create(resource)
        Response::Base.new(resource)
      end

      def self.error(resource, error_object)
        Response::ServerError.new(resource, exception: error_object)
      end
    end
  end
end
