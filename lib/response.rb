# response is responsible for identifying, displaying and delivering resources and messages 
# to the client. It is self contained and capable of handling errors as well.
# File provided by John and remains untouched
require_relative '../lib/config/httpd_conf'
require_relative '../lib/request'
require_relative 'response'

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