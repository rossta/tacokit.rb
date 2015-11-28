require "tacokit/middleware/raise_error"

module Tacokit
  module Middleware
    Faraday::Response.register_middleware raise_error: -> { Tacokit::Middleware::RaiseError }

    module_function

    def default_stack(config = Tacokit.configuration)
      proc do |http|
        http.request :json
        http.request :multipart
        http.request :url_encoded

        http.response :json, content_type: /\bjson$/
        http.response :raise_error
        http.response :logger if ENV["DEBUG"]

        http.adapter Faraday.default_adapter
      end
    end
  end
end
