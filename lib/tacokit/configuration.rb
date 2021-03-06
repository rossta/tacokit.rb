# frozen_string_literal: true
module Tacokit
  class Configuration
    API_URL = "https://api.trello.com".freeze
    WEB_URL = "https://trello.com".freeze

    API_VERSION = "1".freeze

    def self.keys
      [
        :app_key,
        :app_secret,
        :app_token,
        :oauth_token,
        :oauth_secret,
        :api_endpoint,
        :web_endpoint,
        :stack
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
      { consumer_key: app_key, consumer_secret: app_secret, token: oauth_token }.delete_if { |k, v| v.nil? }
    end

    def app_authenticated?
      app_key && app_token
    end

    def app_credentials
      { key: app_key, token: app_token }.delete_if { |k, v| v.nil? }
    end

    def stack
      @stack ||= Faraday::RackBuilder.new(&Middleware.default_stack(self))
      yield @stack if block_given?
      @stack
    end

    private

    def defaults
      {
        api_endpoint: File.join(API_URL, API_VERSION),
        web_endpoint: File.join(WEB_URL, API_VERSION),
        app_key: ENV["TRELLO_APP_KEY"],
        app_secret: ENV["TRELLO_APP_SECRET"],
        app_token: ENV["TRELLO_APP_TOKEN"]
      }
    end
  end
end
