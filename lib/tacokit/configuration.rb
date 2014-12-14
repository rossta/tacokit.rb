module Tacokit
  class Configuration

    API_URL = "https://api.trello.com"
    WEB_URL = "https://trello.com"

    API_VERSION  = "1"

    def self.keys
      [
        :app_key,
        :app_secret,
        :app_token,
        :oauth_token,
        :oauth_secret,
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

    def user_authenticated?
      app_key && oauth_token
    end

    def user_credentials
      { consumer_key: app_key, token: oauth_token }.delete_if { |k, v| v.nil? }
    end

    def app_authenticated?
      app_key && app_token
    end

    def app_credentials
      { key: app_key, token: app_token }.delete_if { |k,v| v.nil? }
    end

    private

    def defaults
      {
        api_endpoint: File.join(API_URL, API_VERSION),
        web_endpoint: File.join(WEB_URL, API_VERSION),
        app_key: ENV['TRELLO_APP_KEY'],
        app_secret: ENV['TRELLO_APP_SECRET'],
        app_token: ENV['TRELLO_APP_TOKEN']
      }
    end

  end
end
