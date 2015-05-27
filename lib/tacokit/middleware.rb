require "tacokit/middleware/raise_error"

module Tacokit
  module Middleware
    Faraday::Response.register_middleware raise_error: -> { Tacokit::Middleware::RaiseError }
  end
end
