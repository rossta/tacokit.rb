module Tacokit
  class Client
    module Authorizations

      def generate_app_key
        open_url web_url("appKey/generate")
      end

      # Params
      # callback_method: "postMessage" or "fragment"
      # return_url: URL the token should be returned to
      # scope: Comma-separated list of one or more of "read", "write", "account"
      # expiration: "1hour", "1day", "30days", "never"
      # name: Name of the application
      # key: Application key
      #
      def authorize(params = {})
        open_url authorize_url(params)
      end

      def authorize_url(params = {})
        key = params.delete(:key) || app_key
        web_url "authorize?key=#{key}", params
      end

      private

      def open_url(url)
        require 'launchy'
        Launchy.open(url)
      rescue LoadError
        warn "Visit #{app_key_url} to generate an app key"
        warn "Please install the launchy gem to open the url automatically."
      end

      def web_url(path, params = {})
        web_connection.build_url(path, params).to_s
      end

      def web_connection
        Faraday::Connection.new(web_endpoint)
      end

    end
  end
end
