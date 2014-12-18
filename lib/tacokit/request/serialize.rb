module Tacokit
  module Request
    class Serialize < Faraday::Middleware

      def call(env)
        env.body = serialize(env.body.dup) if env.body.is_a?(Hash)
        @app.call(env)
      end

      private

      def serialize(body)
        flatten_nested_keys(camelize_keys(body))
      end

      def camelize_keys(body)
        body.deep_transform_keys { |key| camelize_key(key) }
      end

      def camelize_key(key)
        k = key.to_s
        k = k.gsub(%r{(.*)_id(s)?$}, "id_\\1\\2")
        k.camelize(:lower)
      end

      # Converts
      # 'prefs' => { 'voting' => 'members' }
      # to
      # 'prefs/voting' => 'members
      #
      def flatten_nested_keys(body)
        options = {}
        body.each do |key, value|
          if value.is_a?(Hash)
            value = flatten_nested_keys(value.dup)
            value.each do |nested_key, nested_value|
              options["#{key}/#{nested_key}"] = nested_value
            end
            body.delete(key)
          end
        end
        body.merge(options)
      end
    end
  end
end
