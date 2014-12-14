require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'tacokit/configuration'
require 'tacokit/client/authorizations'
require 'tacokit/client/members'
require 'tacokit/client/boards'
require 'tacokit/client/cards'

module Tacokit
  class Client
    extend Forwardable

    include Tacokit::Client::Authorizations
    include Tacokit::Client::Members
    include Tacokit::Client::Boards
    include Tacokit::Client::Cards

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
      response = connection.send(method, url, options) do |conn|
        conn.params = normalize_request_params(conn.params)
      end
      response.body
    end

    # Prepare ruby-style params for trello request
    def normalize_request_params(params)
      {}.tap do |norm|
        params.each do |key,value|
          norm[key] = normalize_param_value(value)
        end
      end
    end

    def normalize_param_value(value)
      case value
      when Array
        value.map { |v| v.camelize(:lower) }.join(',')
      when /\,/
        normalize_param_value(value.split(','))
      else
        value
      end
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
        http.response :logger if ENV['DEBUG']

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
        snakify_keys(body)
      end

      private

      def snakify_keys(body)
        case body
        when Hash
          transform_hash(body)
        when Array
          transform_array(body)
        else
          body
        end
      end

      def transform_array(body)
        body.map { |data| snakify_keys(data) }
      end

      def transform_hash(body)
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
