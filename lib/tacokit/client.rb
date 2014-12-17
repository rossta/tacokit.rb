require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'tacokit/configuration'

require 'tacokit/client/actions'
require 'tacokit/client/authorizations'
require 'tacokit/client/boards'
require 'tacokit/client/cards'
require 'tacokit/client/checklists'
require 'tacokit/client/labels'
require 'tacokit/client/lists'
require 'tacokit/client/members'
require 'tacokit/client/notifications'
require 'tacokit/client/organizations'
require 'tacokit/client/searches'
require 'tacokit/client/tokens'
require 'tacokit/client/types'
require 'tacokit/client/webhooks'

module Tacokit
  class Client
    extend Forwardable

    include Tacokit::Client::Actions
    include Tacokit::Client::Authorizations
    include Tacokit::Client::Boards
    include Tacokit::Client::Cards
    include Tacokit::Client::Checklists
    include Tacokit::Client::Labels
    include Tacokit::Client::Lists
    include Tacokit::Client::Members
    include Tacokit::Client::Notifications
    include Tacokit::Client::Organizations
    include Tacokit::Client::Searches
    include Tacokit::Client::Tokens
    include Tacokit::Client::Types
    include Tacokit::Client::Webhooks

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

    def post(url, options = {})
      request :post, url, options
    end

    def put(url, options = {})
      request :put, url, options
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

        http.request :serialize
        http.request :multipart
        http.request :url_encoded
        http.request :json

        http.response :mashify
        http.response :deserialize
        http.response :json, content_type: /\bjson$/
        http.response :boom
        http.response :logger if ENV['DEBUG']

        http.adapter Faraday.default_adapter
      end
    end

    class Serialize < Faraday::Middleware

      def call(env)
        env.body = transform_body_keys(env.body.dup) if env.body.is_a?(Hash)
        @app.call(env)
      end

      private

      def transform_body_keys(body)
        flatten_nested_keys(camelize_keys(body))
      end

      def camelize_keys(body)
        body.deep_transform_keys do |key|
          key.to_s.camelize(:lower)
        end
      end

      # Converts
      # 'prefs' => { 'voting' => 'members' }
      # to
      # 'prefs/voting' => 'members
      #
      def flatten_nested_keys(body)
        options = {}
        body.each do |key, value|
          if value.is_a?(Hash)
            value.each do |nested_key, nested_value|
              options["#{key}/#{nested_key}"] = nested_value
            end
            body.delete(key)
          end
        end
        body.merge(options)
      end

    end

    # Used for simple response middleware.
    class Deserialize < Faraday::Response::Middleware
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

    class Boom < Faraday::Response::Middleware
      ClientErrorStatuses = 400...600

      def on_complete(env)
        case env[:status]
        when 404
          raise Faraday::Error::ResourceNotFound, response_values(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Faraday::Error::ConnectionFailed, %{407 "Proxy Authentication Required "}
        when ClientErrorStatuses
          raise Faraday::Error.new("server return #{env[:status]}: #{env.body}")
        end
      end

      def response_values(env)
        {:status => env.status, :headers => env.response_headers, :body => env.body}
      end
    end

    Faraday::Request.register_middleware \
      :serialize => lambda { Serialize }

    Faraday::Response.register_middleware \
      :deserialize => lambda { Deserialize },
      :debug => lambda { Debug },
      :boom => lambda { Boom }

  end
end
