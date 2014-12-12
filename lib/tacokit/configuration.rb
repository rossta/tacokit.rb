module Tacokit
  class Configuration

    API_URL = "https://api.trello.com"
    WEB_URL = "https://trello.com"

    API_VERSION  = "1"

    APP_KEY_URL  = "https://trello.com/1/appKey/generate"

    def self.keys
      [
        :app_key,
        :app_secret,
        :consumer_key,
        :consumer_secret,
        :oauth_token,
        :oauth_token_secret,
        :api_endpoint,
        :web_endpoint
      ]
    end

    attr_accessor(*keys)

    def initialize(opts = {})
      self.options = defaults.merge(opts)
    end

    def options=(opts)
      opts.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def credentials
      case
      when oauth?
        oauth_credentials
      when basic?
        basic_credentials
      else
        raise ConfigurationError.new("Not configured")
      end
    end

    def oauth?
      consumer_key && consumer_secret
    end

    def basic?
      app_key && app_secret
    end

    private

    def oauth_credentials
      {
        :consumer_key => consumer_key,
        :consumer_secret => consumer_secret,
        :oauth_token => oauth_token,
        :oauth_token_secret => oauth_token_secret
      }.delete_if { |key, value| value.nil? }
    end

    def basic_credentials
      {
        :app_key => app_key,
        :app_secret => app_secret
      }
    end

    def defaults
      {
        api_endpoint: File.join(API_URL, API_VERSION),
        web_endpoint: File.join(WEB_URL, API_VERSION),
        app_key: ENV['TRELLO_APP_KEY'],
        app_secret: ENV['TRELLO_APP_SECRET']
      }
    end

  end
end
