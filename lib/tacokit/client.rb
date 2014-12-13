require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'tacokit/configuration'
require 'tacokit/client/authorizations'
require 'tacokit/client/members'

module Tacokit
  class Client
    extend Forwardable

    include Tacokit::Client::Authorizations
    include Tacokit::Client::Members

    def_delegators :configuration, *Configuration.keys
    def_delegators :configuration, :user_authenticated?, :user_credentials
    def_delegators :configuration, :app_authenticated?, :app_credentials

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

        if user_authenticated?
          http.request :oauth, user_credentials
        else app_authenticated?
          http.params.merge! app_credentials
        end

        http.response :mashify
        http.response :snakify
        http.response :json, content_type: /\bjson$/
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
