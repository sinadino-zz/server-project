require_relative 'configuration'

# Parses, stores and exposes the values from the mime.types file
module WebServer
  class MimeTypes < Configuration

    

    def initialize(options={})
      # extract configuration options from options hash, or revert to defaults
      rel_dir = options[:configuration_directory] ? options[:configuration_directory] : './config'
      rel_file = (options[:mime_file].nil?) ? 'mime.types' : options[:mime_file]
      @config_file = File.new(File.expand_path(rel_dir + '/' + rel_file), 'r')
    end
    #find me the mime type
    def for_extension(extension)
      
      # open file for reading
      File.open(File.expand_path(@config_file)) do |file|

        file.each_line do |linefull|
          line = linefull.split 
          line.each_with_index do |item, index|
            if (index > 0 && item == extension)
              return line[0]
            end
          end
        end
      end
        return nil # in case nothing is found
    end
  end
end


