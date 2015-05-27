module Tacokit
  module Middleware
    class RaiseError < Faraday::Response::Middleware
      CLIENT_ERROR_STATUSES = 400...600

      def on_complete(env)
        case env[:status]
        when 401
          raise Tacokit::Error::Unauthorized, error_message(env)
        when 404
          raise Tacokit::Error::ResourceNotFound, error_message(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Tacokit::Error::ConnectionFailed, %(407 "Proxy Authentication Required ")
        when 408
          raise Tacokit::Error::TimeoutError, error_message(env)
        when CLIENT_ERROR_STATUSES
          raise Tacokit::Error::ClientError, error_message(env)
        end
      end

      def error_message(env)
        "Server returned #{env[:status]}: #{env.body}. Headers #{env.response_headers.inspect}"
      end
    end
  end
end
