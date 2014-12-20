module Tacokit
  module Middleware

    class Debug < Faraday::Response::Middleware
      require 'pry'

      def on_complete(env)
        binding.pry
        env
      end

      def parse(body)
        binding.pry
        body
      end
    end

  end
end
