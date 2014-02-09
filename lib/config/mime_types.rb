require_relative 'configuration'

# Parses, stores and exposes the values from the mime.types file
module WebServer
  class MimeTypes < Configuration
    def initialize(options={})
    end
    
    # Returns the mime type for the specified extension
    def for_extension(extension)
    end
  end
end
