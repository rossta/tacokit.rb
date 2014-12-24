module Tacokit
  module Middleware
    class Boom < Faraday::Response::Middleware
      ClientErrorStatuses = 400...600

      def on_complete(env)
        case env[:status]
        when 401
          raise Tacokit::Error::Unauthorized.new(error_message(env))
        when 404
          raise Tacokit::Error::ResourceNotFound.new(error_message(env))
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Tacokit::Error::ConnectionFailed, %{407 "Proxy Authentication Required "}
        when ClientErrorStatuses
          raise Tacokit::Error::ClientError.new(error_message(env))
        end
      end

      def error_message(env)
        "Server returned #{env[:status]}: #{env.body}. Headers #{env.response_headers.inspect}"
      end

    end
  end
end
