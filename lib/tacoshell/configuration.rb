module Tacoshell
  Error = Class.new(StandardError)
  ConfigurationError = Class.new(Error)

  class Configuration

    def self.keys
      [
        :app_key,
        :app_secret,
        :consumer_key,
        :consumer_secret,
        :oauth_token,
        :oauth_token_secret
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
      {}
    end

  end
end
