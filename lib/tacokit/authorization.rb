module Tacokit
  module Authorization
    def get_app_key # rubocop:disable Style/AccessorMethodName
      open_url web_url("appKey/generate")
    end

    # Get a token for making authorized requests to the Trello API
    #
    # @param [String, #read] contents the contents to reverse
    # @param options [Hash] Repository information to update
    # @option options [String] :name Name of the application
    # @option options [String] :key Application key
    # @option options [String] :callback_method "postMessage" or "fragment"
    # @option options [String] :return_url URL the token should be returned to
    # @option options [String] :scope Comma-separated list of one or more of "read", "write", "account"
    # @option options [String] :expiration "1hour", "1day", "30days", "never"
    # @see https://trello.com/docs/gettingstarted/authorize.html
    def authorize(params = {})
      open_url authorize_url(params)
    end

    def authorize_url(params = {})
      params[:key] ||= app_key
      params[:name] ||= "Tacokit"
      params[:response_type] ||= "token"
      web_url "authorize", params
    end

    private

    def open_url(url)
      require "launchy"
      Launchy.open(url)
    rescue LoadError
      warn "Visit #{url}"
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
