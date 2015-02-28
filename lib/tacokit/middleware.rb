require "tacokit/middleware/boom"

module Tacokit
  module Middleware
    Faraday::Response.register_middleware boom: -> { Tacokit::Middleware::Boom }
  end
end
