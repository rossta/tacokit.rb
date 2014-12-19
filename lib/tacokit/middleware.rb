require 'tacokit/middleware/serialize'
require 'tacokit/middleware/boom'
require 'tacokit/middleware/deserialize'
require 'tacokit/middleware/materialize'

module Tacokit
  module Middleware

    Faraday::Request.register_middleware \
      :serialize => lambda { Tacokit::Middleware::Serialize }

    Faraday::Response.register_middleware \
      :boom => lambda { Tacokit::Middleware::Boom },
      :deserialize => lambda { Tacokit::Middleware::Deserialize },
      :materialize => lambda { Tacokit::Middleware::Materialize }

  end
end
