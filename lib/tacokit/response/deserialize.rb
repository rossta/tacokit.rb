module Tacokit
  module Response
    class Deserialize < Faraday::Response::Middleware

      def parse(body)
        snakify_keys(body)
      end

      private

      def snakify_keys(body)
        case body
        when Hash
          transform_hash(body)
        when Array
          transform_array(body)
        else
          body
        end
      end

      def transform_array(body)
        body.map { |data| snakify_keys(data) }
      end

      def transform_hash(body)
        body.deep_transform_keys do |key|
          key.underscore
        end
      end
    end
  end
end
