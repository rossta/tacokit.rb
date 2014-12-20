require 'tacokit/middleware/boom'
require 'tacokit/middleware/debug'

module Tacokit
  module Middleware

    # Faraday::Request.register_middleware \
    #   :example => lambda { Tacokit::Middleware::Example }
    #

    Faraday::Response.register_middleware \
      :boom => lambda { Tacokit::Middleware::Boom },
      :debug => lambda { Tacokit::Middleware::Debug }

  end
end
