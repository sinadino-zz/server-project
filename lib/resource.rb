module WebServer
  class Resource
    attr_reader :request, :conf

    def initialize(request, httpd_conf)
      @request = request
      @conf = httpd_conf
    end
  end
end
