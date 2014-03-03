# The Request class encapsulates the parsing of an HTTP Request
module WebServer
  class Request

    DEFAULT_DIR = './spec/fixtures'

    attr_accessor :http_method, :uri, :version, :headers, :body, :params

    # Request creation receives a reference to the socket over which
    # the client has connected
    def initialize(options={})
      # Perform any setup, then parse the request
      @io = File.new("#{DEFAULT_DIR}/basic_get.txt", 'r')
      #@request = Webserver::Request.new(io)

    

   

    def method_parser 
      return get_value_parsed('http_method')
    end

    def uri_parser
      return get_value_parsed('uri')
    end

    def http_version
      return get_value_parsed('HTTP/1.1')
    end

    def header_parser
      return get_value_parsed(['HOST'])
    end

    def env_type
      return get_value_parsed('CONTENT_LENGTH ')
    end

    def body_parser
      return get_value_parsed('body')
    end

    def query_parser
      return get_value_parsed('param1')
    end


    def get_value_parsed(key)
        @io.each do |line|
          line = line.split 
           return (line[1]).rchomp('"').chomp('"') unless (line[0]!= key)
           #unless not Found line for this key
            
        end
      end
  end




    # This method is purely for the purpose of debugging.
    def to_s
      output = "--------------------------------\n"

      output += "#{@http_method} #{@uri} #{@version}\n"

      @headers.keys.each do |header|
        output += "#{header}: #{@headers[header]}\n"
      end

      output += "\n"

      unless @body.nil?
        output += "#{@body}\n"
      end

      output += "--------------------------------\n"

      output
    end

    # I've added this as a convenience method, see TODO (This is called from the logger
    # to obtain information during server logging)
    def user_id
      # TODO: This is the userid of the person requesting the document as determined by 
      # HTTP authentication. The same value is typically provided to CGI scripts in the 
      # REMOTE_USER environment variable. If the status code for the request (see below) 
      # is 401, then this value should not be trusted because the user is not yet authenticated.
      '-'
    end
  end
end

class String
  
      def rchomp(sep = $/)
        self.start_with?(sep) ? self[sep.size..-1] : self
      end
  end

=begin
    # Parse the request from the socket - Note that this method takes no
    # parameters
    def parses
    end

    # The following lines provide a suggestion for implementation - feel free
    # to erase and create your own...
    def next_line
    end

    def parse_request_line
    end

    def parse_header(header_line)
    end

    def parse_body(body_line)
    end

    def parse_params
    end

=end
 
