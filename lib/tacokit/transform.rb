module Tacokit
  class Transform
    include Tacokit::Utils

    def serialize(body)
      serialize_body(body)
    end

    def deserialize(body)
      deserialize_body(body)
    end

    private

    def serialize_body(body)
      case body
      when Hash
        serialize_hash(body)
      else
        body
      end
    end

    def serialize_hash(body)
      flatten_nested_keys(camelize_keys(body))
    end

    def camelize_keys(body)
      deep_transform_keys(body) { |key| camelize_key(key) }
    end

    def camelize_key(key)
      k = key.to_s
      k = k.gsub(%r{([a-zA-Z]+?)_id(s\b|\b)?$}, "id_\\1\\2")
      camelize(k, :lower)
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

    def deserialize_body(body)
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
      body.map { |data| deserialize_body(data) }
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