module Tacokit
  module Middleware
    class Deserialize < Faraday::Response::Middleware
      include Tacokit::Utils

      def parse(body)
        $stdout.puts "Deserializing #{body.inspect}" if ENV['DEBUG']
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
          underscore_key(key)
        end
      end

      def underscore_key(key)
        k = key.to_s
        k = k.gsub(%r{(#{pluralize_special_cases.join('|')})}, "\\1s")
        k = underscore(k)
        k.gsub(%r{^id_([a-zA-Z_]+?)(s\b|\b)$}, "\\1_id\\2")
      end

      def pluralize_special_cases
        %w[ idBoardsPinned idPremOrgsAdmin ]
      end
    end
  end
end
