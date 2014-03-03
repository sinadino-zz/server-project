require_relative 'configuration'


# tokenize input, store, and flash out properties from the httpd.conf file
module WebServer
  class HttpdConf < Configuration

   
    # parse configuration properties from  hash, or reset to defaults
    def initialize(options={})
      rel_dir = options[:configuration_directory] ? options[:configuration_directory] : './config'
      rel_file = (options[:rel_file].nil?) ? 'httpd.conf' : options[:rel_file]
      @config_file = File.new(File.expand_path(rel_dir + '/' + rel_file), 'r')
    end

    




    # Returns the value of the ServerRoot
    def server_root
      return fetch_conf_value('ServerRoot')
    end

    # Returns the value of the DocumentRoot
    def document_root
      return fetch_conf_value('DocumentRoot')
    end

    # Returns the directory index file
    def directory_index
      return fetch_conf_value('DirectoryIndex')
    end

    # Returns the *integer* value of Listen
    def port
      return fetch_conf_value('Listen').to_i
    end

    # Returns the value of LogFile
    def log_file
      return fetch_conf_value('LogFile')
    end

    # Returns the name of the AccessFile 
    def access_file_name
      return fetch_conf_value('AccessFileName')
    end

    # Returns an array of ScriptAlias directories
    def script_aliases
      return fetch_conf_values('ScriptAlias')
    end

    # Returns the aliased path for a given ScriptAlias directory
    def script_alias_path(path)
      return script_aliases[path]
    end

    # Returns an array of Alias directories
    def aliases
      return fetch_conf_values('Alias')
    end

    # Returns the aliased path for a given Alias directory
    def alias_path(path)
      return aliases[path]
    end


  

  
     #reading lines comparing key value against target
     def fetch_conf_value(key)
        @config_file.each do |line|
          line = line.split 
           return (line[1]).rchomp('"').chomp('"') unless (line[0]!= key)
           #unless not Found line for this key
            
        end
      end
 
 


      # search for a hash of config key-value pairs by its key
      def fetch_conf_values(key)
        config_properties = {}
        @config_file.each do |line|
           line = line.split
           config_properties[line[1]] = (line[2]).rchomp('"').chomp('"') unless (line[0] != key) 
        end
         return config_properties
      end

  end
end


  # this is a extra functionalaity recommended 
  class String
  
      def rchomp(sep = $/)
        self.start_with?(sep) ? self[sep.size..-1] : self
      end
  end





