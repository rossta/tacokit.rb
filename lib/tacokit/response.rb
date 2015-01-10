module Tacokit
  class Response

    attr_reader :client, :status, :headers, :env, :body

    def initialize(client, res, options = {})
      @client   = client
      @status   = res.status
      @headers  = res.headers
      @env      = res.env
      @body     = res.body
    end

    def data
      @data ||= process_data(@client.deserialize(@body))
    end

    private

    def process_data(data)
      case data
      when Hash then Resource.new(data)
      when Array then data.map { |value| process_data(value) }
      else data
      end
    end
  end
end
