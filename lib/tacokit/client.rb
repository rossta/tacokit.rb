require 'forwardable'
require 'faraday'
require 'faraday_middleware'
require 'hashie/mash'

require 'tacokit/configuration'
require 'tacokit/middleware'
require 'tacokit/authorization'

require 'tacokit/client/actions'
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

    include Tacokit::Authorization
    include Tacokit::Utils

    include Tacokit::Client::Actions
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

    def delete(url, options = {})
      request :delete, url, options
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
        value.map { |v| to_path(v) }.join(',')
      when /\,/
        normalize_param_value(value.split(','))
      else
        value
      end
    end

    def to_path(path)
      camelize(path.to_s, :lower)
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
        http.request :json
        http.request :multipart
        http.request :url_encoded

        http.response :mashify
        http.response :deserialize
        http.response :json, content_type: /\bjson$/
        http.response :boom
        http.response :logger if ENV['DEBUG']

        http.adapter Faraday.default_adapter
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

    Faraday::Response.register_middleware :debug => lambda { Debug }

  end
end
