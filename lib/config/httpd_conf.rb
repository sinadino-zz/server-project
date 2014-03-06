#although relative path is required most of its implementation is done here
require_relative 'configuration'

# instead of using inheritance, object behavior is described here not in configuration.rb 
# this decision made easier to implement desired behavior and understand the general idea of
# web server construct. 
# Parses, stores, and exposes the values from the httpd.conf file
module WebServer

  class HttpdConf < Configuration

    attr_accessor :the_file,:server_root,:document_root, :directory_index,:port, :log_file,:access_file_name, :script_alias,:aliases
                  

    def initialize(options={})
      super options
      #assign file into the @conf_file variable for later usage
      @conf_file = options[:conf_file]
      file_name = File.join @configuration_directory, @conf_file

      @the_file = File.new(file_name, "r")
    end

    # Returns the value of the ServerRoot
    # we check to see if server root is empty else we return value its actual value
    def server_root
      if (@server_root == nil)
        read_http_config
      end
      return @server_root
    end

    # Returns the value of the DocumentRoot
    # same approach, if  document root is empty we invoke metod
    def document_root
      if (@document_root == nil)
        read_http_config
      end
      return @document_root
    end

    # Returns the directory index file
    def directory_index
      if (@directory_index == nil)
        read_http_config
      end
      return @directory_index
    end

    # Returns the *integer* value of Listen
    def port
      if (@port == nil)
        read_http_config
      end
      return @port
    end

    # Returns the value of LogFile
    def log_file
      if (@log_file == nil)
        read_http_config
      end
      return @log_file
    end

    # Returns the name of the AccessFile 
    def access_file_name
      if  (@access_file_name == nil)
        read_http_config
      end
      return @access_file_name
    end

    # Returns an array of ScriptAlias directories
    def script_aliases
      if  (@script_alias == nil)
        read_http_config
      end
      return @script_alias
    end

    # Returns the aliased path for a given ScriptAlias directory
    def script_alias_path(path)
      if (@script_alias_paths == nil)
        read_http_config
      end
      @script_alias_paths.each do |x|
        if (x[0] == path)
          return x[1]
        end
      end
      return nil
    end

    # Returns an array of Alias directories
    def aliases
      if (@aliases == nil)
        read_http_config
      end
      return @aliases
    end

    # Returns the aliased path for a given Alias directory
    def alias_path(path)
      if (@aliases_paths == nil)
        read_http_config
      end
      @aliases_paths.each do |x|
        if (x[0] == path)
          return x[1]
        end
      end
      return nil
    end
    # despite the ungliness of the code it gets the job done.
    # we iterate throug file spliting lines and matching keys
    def read_http_config

      file_content = File.readlines @the_file

      file_content.each do |line|
        a = line.split " "

        if (a[0].start_with? "DocumentRoot")
          @document_root = a[1].gsub(/[^0-9A-Za-z\/_.]/, '')
        elsif a[0].start_with? "ServerRoot"
          @server_root = a[1].gsub(/[^0-9A-Za-z\/_.]/, '')
        elsif a[0].start_with? "Listen"
          @port = a[1].to_i
        elsif a[0].start_with? "LogFile"
          @log_file = a[1].gsub(/[^0-9A-Za-z\/_.]/, '')
        elsif a[0].start_with? "Alias"
          (@aliases ||= []).push a[1].gsub(/[^0-9A-Za-z\/_.~-]/, '')
          (@aliases_paths ||= []).push ([a[1].gsub(/[^0-9A-Za-z\/_.~-]/, ''), a[2].gsub(/[^0-9A-Za-z\/_.~-]/, '')])
        elsif a[0].start_with? "ScriptAlias"
          (@script_alias ||= []).push a[1].gsub(/[^0-9A-Za-z\/_.~-]/, '')
          (@script_alias_paths ||= []).push [a[1].gsub(/[^0-9A-Za-z\/_.~-]/, ''), a[2].gsub(/[^0-9A-Za-z\/_.~-]/, '')]
        elsif a[0].start_with? "DirectoryIndex"
          @directory_index = a[1].gsub(/[^0-9A-Za-z\/_.]/, '')
        elsif a[0].start_with? "AccessFileName"
          @access_file_name = a[1].gsub(/[^0-9A-Za-z\/_.]/, '')
        end
      end
    end

  end
end
=begin
FIXTURES_DIRECTORY = File.join File.dirname(__FILE__), '../../config'
puts FIXTURES_DIRECTORY

var = WebServer::HttpdConf.new ( { :configuration_directory => FIXTURES_DIRECTORY, :conf_file => 'httpd.conf' } )
puts var.server_root
puts var.document_root
puts var.port
puts var.log_file
puts var.directory_index
puts var.access_file_name
puts var.aliases
puts var.server_root
=end