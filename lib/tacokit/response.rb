module Tacokit
  class Response

    attr_reader :client, :status, :headers, :env, :data

    def initialize(client, res, options = {})
      @client   = client
      @status   = res.status
      @headers  = res.headers
      @env      = res.env
      @data     = process_data(@client.deserialize(res.body))
    end

    def process_data(data)
      case data
      when Hash then Resource.new(client, data)
      when Array then data.map { |value| process_data(value) }
      else data
      end
    end

  end
end
