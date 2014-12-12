require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'tacokit/client/authorizations'
require 'tacokit/client/members'

module Tacokit
  class Client
    extend Forwardable

    include Tacokit::Client::Authorizations
    include Tacokit::Client::Members

    def_delegators :configuration, *Configuration.keys

    def initialize(options = {})
      self.configuration.options = options
    end

    def reset!
      @configuration = nil
    end

    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def get(url, options = {})
      request :get, url, options
    end

    def request(method, url, options)
      response = connection.send(method, url, options)
      response.body
    end

    def connection
      @connection = Faraday.new(url: api_endpoint) do |http|
        http.response :mashify
        http.response :snakify
        http.response :json
        http.response :logger
        http.adapter Faraday.default_adapter
      end
    end

     # Used for simple response middleware.
    class Snakify < Faraday::Response::Middleware
      require 'active_support/core_ext/hash'
      require 'active_support/core_ext/string'

      def parse(body)
        return body unless body.is_a?(Hash)

        body.deep_transform_keys do |key|
          key.underscore
        end
      end
    end

    Faraday::Response.register_middleware \
      :snakify => lambda { Snakify }
  end
end
