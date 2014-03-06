require_relative 'configuration'

# Parses, stores and exposes the values from the mime.types file
module WebServer
  class MimeTypes < Configuration

    attr_accessor :the_file


    def initialize(options={})
      super options

      @mime_file = options[:mime_file]
      file_name = File.join @configuration_directory, @mime_file

      @the_file = File.new(file_name, "r")
    end
    
    # Returns the mime type for the specified extension
    def for_extension(extension)

      file_content = File.readlines @the_file

      file_content.each do |line|
        if (line.include? extension)
          a = line.split " "
          return a[0]
        end
      end

    end
  end
end

=begin
FIXTURES_DIRECTORY = File.join File.dirname(__FILE__), '../../config'
puts FIXTURES_DIRECTORY
#puts Dir.entries FIXTURES_DIRECTORY

var = WebServer::MimeTypes.new ( { :configuration_directory => FIXTURES_DIRECTORY, :mime_file => 'mime.types' } )
puts var.for_extension("png")
puts var.for_extension("jpeg")
puts var.for_extension("jpg")
puts var.for_extension("jpe")
#var.mine_type_file.readlines.each do  |line|
#    if (line.include? "jpg")
#      a = line.split " "
#      puts a[0]
#    end
#  end
=end

#var = WebServer::MimeTypes.new ( { :configuration_directory => FIXTURES_DIRECTORY, :mime_file => 'mime.types' } )
