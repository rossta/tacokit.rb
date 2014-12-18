module Tacokit
  module Response
    class Boom < Faraday::Response::Middleware
      ClientErrorStatuses = 400...600

      def on_complete(env)
        case env[:status]
        when 404
          raise Faraday::Error::ResourceNotFound, response_values(env)
        when 407
          # mimic the behavior that we get with proxy requests with HTTPS
          raise Faraday::Error::ConnectionFailed, %{407 "Proxy Authentication Required "}
        when ClientErrorStatuses
          raise Faraday::Error.new("server return #{env[:status]}: #{env.body}")
        end
      end

      def response_values(env)
        {:status => env.status, :headers => env.response_headers, :body => env.body}
      end
    end
  end
end
