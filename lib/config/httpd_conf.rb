require_relative 'configuration'


# parse, store, and flash out properties from the httpd.conf file
module WebServer
  class HttpdConf < Configuration

   
    # parse configuration properties from  hash, or reset to defaults
    def initialize(options={})
      rel_dir = options[:configuration_directory] ? options[:configuration_directory] : './config'
      rel_file = (options[:rel_file].nil?) ? 'httpd.conf' : options[:rel_file]
      @config_file = File.new(File.expand_path(rel_dir + '/' + rel_file), 'r')
    end 




 
    def server_root
      return fetchConfigValue('ServerRoot')
    end

  
    def document_root
      return fetchConfigValue('DocumentRoot')
    end

   
    def directory_index
      return fetchConfigValue('DirectoryIndex')
    end


    def port
      return fetchConfigValue('Listen').to_i
    end

 
    def log_file
      return fetchConfigValue('LogFile')
    end


    def access_file_name
      return fetchConfigValue('AccessFileName')
    end

    
    def script_aliases
      return fetchConfigValues('ScriptAlias')
    end


    def script_alias_path(path)
      return script_aliases[path]
    end

 
    def aliases
      return fetchConfigValues('Alias')
    end

    
    def alias_path(path)
      return aliases[path]
    end


  

  

     def fetchConfigValue(key)
        @config_file.each do |line|
          line = line.split 
           return (line[1]).rchomp('"').chomp('"') unless (line[0]!= key)
           #unless not Found line for this key
            
        end
      end
 
 


     
      def fetchConfigValues(key)
        config_properties = {}
        @config_file.each do |line|
           line = line.split
           config_properties[line[1]] = (line[2]).rchomp('"').chomp('"') unless (line[0] != key) 
        end
         return config_properties
      end

  end
end



  class String
  
      def rchomp(sep = $/)
        self.start_with?(sep) ? self[sep.size..-1] : self
      end
  end



