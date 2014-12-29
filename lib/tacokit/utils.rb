# Emulate only what we need from activesupport
module Tacokit
  module Utils

    def deep_transform_keys(hash, &block)
      _deep_transform_keys_in_object(hash, &block)
    end

    def extract_options(*args)
      opts = args.last.is_a?(Hash) ? args.pop : {}
      return args, opts
    end

    def underscore(string)
      string.gsub(/::/, '/').
        gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
        gsub(/([a-z\d])([A-Z])/,'\1_\2').
        tr("-", "_").
        downcase
    end

    def camelize(string, lower = false)
      string = string.to_s.gsub(/(?:^|_)(.)/) { $1.upcase }
      string = string[0].chr.downcase + string[1..-1] if lower
      string
    end

    def blank?(obj)
      obj.respond_to?(:empty?) ? !!obj.empty? : !obj
    end

    def present?(obj)
      !blank?(obj)
    end

    private

    def _deep_transform_keys_in_object(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), result|
          result[yield(key)] = _deep_transform_keys_in_object(value, &block)
        end
      when Array
        object.map {|e| _deep_transform_keys_in_object(e, &block) }
      else
        object
      end
    end
  end
end
