require 'pry'
module Tacokit
  module Middleware

    class Debug < Faraday::Response::Middleware
      def on_complete(env)
        binding.pry
        env
      end

      def parse(body)
        binding.pry
        body
      end
    end

    Faraday::Response.register_middleware \
      :debug => lambda { Tacokit::Middleware::Debug }

  end
end

