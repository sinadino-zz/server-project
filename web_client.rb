require 'socket'
require 'lib/config/httpd_conf'
Dir.glob('lib/**/*.rb').each do |file|
 require file
end

conf_file = 'httpd.conf'
directory = File.join File.dirname(__FILE__), 'config'
options = { :conf_file => conf_file, :configuration_directory => directory}

hostname = 'localhost'

port = WebServer::HttpdConf.new(options).port

s = TCPSocket.open(hostname, port)

while line = s.gets   # Read lines from the socket
  puts line.chop      # And print with platform line terminator
end
s.close               # Close the socket when done