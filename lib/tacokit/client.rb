require 'forwardable'

require 'addressable/uri'

require 'faraday'
require 'faraday_middleware'

require 'tacokit/authorization'
require 'tacokit/configuration'
require 'tacokit/middleware'
require 'tacokit/response'
require 'tacokit/transform'

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
    def_delegators :transform, :serialize, :deserialize, :serialize_params

    attr_accessor :last_response

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

    def request(method, url, data = nil, params = nil)
      if [:get, :body].include?(method)
        params ||= data
        data      = nil
      end

      response = connection.send method, url do |req|
        req.params.update serialize_params(params)
        req.body = serialize(data) if data
      end

      @last_response = last_response = Response.new(self, response)

      last_response.data
    end

    def to_s
      "<#{self.class}:#{object_id}>"
    end
    alias_method :inspect, :to_s

    private

    def transform
      @transform ||= Transform.new
    end

    def connection
      @connection ||= Faraday.new(url: api_endpoint) do |http|
        http.headers[:user_agent] = 'TacoKit 0.0.1'

        if user_authenticated?
          http.request :oauth, user_credentials
        else app_authenticated?
          http.params.update app_credentials
        end

        http.request :json
        http.request :multipart
        http.request :url_encoded

        http.response :json, content_type: /\bjson$/
        http.response :boom
        http.response :logger if ENV['DEBUG']

        http.adapter Faraday.default_adapter
      end
    end

  end
end
