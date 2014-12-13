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
        http.headers[:user_agent] = 'TacoKit 0.0.1'

        if configuration.oauth?
          http.request :oauth, configuration.simple_oauth_credentials
        end

        http.response :mashify
        http.response :snakify
        http.response :json, content_type: /\bjson$/
        # http.response :debug
        http.response :raise_error
        http.response :logger
        http.adapter Faraday.default_adapter
      end
    end

    class AppKey < Faraday::Middleware
      def initialize(app, app_key)
        @app_key = app_key
        super(app)
      end

      def call(env)
        @app.call(env)
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

     # Used for simple response middleware.
    class Debug < Faraday::Response::Middleware
      require 'pry'

      def on_complete(env)
        binding.pry
        env
      end

      def parse(body)
        binding.pry
        body
      end
    end

    Faraday::Request.register_middleware \
      :app_key => lambda { AppKey }

    Faraday::Response.register_middleware \
      :snakify => lambda { Snakify }

    Faraday::Response.register_middleware \
      :debug => lambda { Debug }

  end
end
