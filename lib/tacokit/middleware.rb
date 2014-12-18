require 'tacokit/request/serialize'
require 'tacokit/response/boom'
require 'tacokit/response/deserialize'

module Tacokit
  module Middleware

    Faraday::Request.register_middleware \
      :serialize => lambda { Tacokit::Request::Serialize }

    Faraday::Response.register_middleware \
      :boom => lambda { Tacokit::Response::Boom },
      :deserialize => lambda { Tacokit::Response::Deserialize }

  end
end
