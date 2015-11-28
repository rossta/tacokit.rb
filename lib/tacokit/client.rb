require "forwardable"

require "addressable/uri"

require "faraday"
require "faraday_middleware"

require "tacokit/authorization"
require "tacokit/collection"
require "tacokit/configuration"
require "tacokit/middleware"
require "tacokit/response"
require "tacokit/transform"

require "tacokit/client/actions"
require "tacokit/client/boards"
require "tacokit/client/cards"
require "tacokit/client/checklists"
require "tacokit/client/labels"
require "tacokit/client/lists"
require "tacokit/client/members"
require "tacokit/client/notifications"
require "tacokit/client/organizations"
require "tacokit/client/searches"
require "tacokit/client/tokens"
require "tacokit/client/types"
require "tacokit/client/webhooks"

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
    def_delegators :transform, :serialize, :deserialize, :serialize_params

    attr_accessor :last_response

    def initialize(options = {})
      configuration.options = options
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

    def paginated_get(*args)
      Collection.new(self, :get, *args)
    end

    def request(method, url, data = nil, params = nil)
      if [:get, :body].include?(method)
        params ||= data
        data = nil
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

    def connection_options
      {
        url: api_endpoint,
        builder: configuration.stack,
        headers: { user_agent: "Tacokit #{Tacokit::VERSION}" }
      }
    end

    def connection
      @connection ||= Faraday.new(connection_options) do |http|
        if configuration.user_authenticated?
          http.request :oauth, configuration.user_credentials
        elsif configuration.app_authenticated?
          http.params.update configuration.app_credentials
        end
      end
    end
  end
end
