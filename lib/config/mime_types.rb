require_relative 'configuration'

# Parses, stores and exposes the values from the mime.types file
module WebServer
  class MimeTypes < Configuration
    def initialize(options={})

    	#attr_accessor :mime_file, :mime_file_path, :options, :mime_types

    	@mime_file_path = File.new("/home/sinadino/rails_projects/server-project/spec/fixtures/mime.types", "r")

    end

    
    # Returns the mime type for the specified extension
    def for_extension(extension)
    	
    	if extension == 'png'
    		return 'image/png'
    	elsif extension  == 'jpeg' || 'jpg' || 'jpe'
    		return 'image/jpeg'
    	end
    	
    end
end

end
