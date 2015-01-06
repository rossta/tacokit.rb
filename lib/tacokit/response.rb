module Tacokit
  class Response

    attr_reader :client, :status, :headers, :env, :data

    def initialize(client, res, options = {})
      @client   = client
      @status   = res.status
      @headers  = res.headers
      @env      = res.env
      @data     = Resource[@client.deserialize(res.body)]
    end

  end
end
