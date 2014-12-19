module Tacokit
  module Response
    class Deserialize < Faraday::Response::Middleware
      include Tacokit::Utils

      def parse(body)
        snakify_keys(body)
      end

      private

      def snakify_keys(body)
        case body
        when Hash
          deserialize_hash(body)
        when Array
          deserialize_array(body)
        else
          body
        end
      end

      def deserialize_array(body)
        body.map { |data| snakify_keys(data) }
      end

      def deserialize_hash(body)
        deep_transform_keys(body) do |key|
          underscore(key)
        end
      end
    end
  end
end
