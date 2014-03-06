# resource is initialized to interact with request and response
# the goal here is to configure resources, based on the request 
# and provide them to response
require_relative '../lib/config/httpd_conf'
require_relative '../lib/request'
require_relative '../lib/response'

module WebServer
  class Resource
    attr_reader :request, :conf, :mimes

    def initialize(request, httpd_conf, mimes)
      @request = request
      @conf = httpd_conf
      @mimes = mimes
    end

    

    # method resolve decides which path should be return depending on what aliases has 
    # been provided the script.
    def resolve


      if (@conf.aliases.empty? and !script_aliased?)
        return "#{@conf.document_root}#{@request.uri}/#{@conf.directory_index}"
      elsif (@conf.aliases.empty? and !@conf.script_alias.empty?)
        return "#{@conf.document_root}#{@conf.script_alias_path(@conf.script_alias[0])}/#{@request.uri.split("/").last}"
      else
        return "#{@conf.document_root}#{@conf.alias_path(@conf.aliases[0])}/#{@request.uri.split("/").last}/#{@conf.directory_index}"
      end

    end

  
    # boolean method verifying aliases presence
    def script_aliased?
      !@conf.script_alias.empty?
    end
    # boolean method verifying whether url is protected or not
    def protected?
      #body up to return false uncommented
      #if (@request.uri.split("/").first == "protected")
      #  return true
      # end
      return false
    end

  end
end