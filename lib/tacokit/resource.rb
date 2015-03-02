require "set"
require "forwardable"

module Tacokit
  class Resource
    include Enumerable
    extend Forwardable

    SPECIAL_METHODS = Set.new(%w[fields])
    attr_reader :_fields
    attr_reader :attrs
    alias_method :to_hash, :attrs
    alias_method :to_h, :attrs

    def_delegators :@_fields, :fetch, :keys, :any?

    def initialize(data = {})
      @attrs = {}
      @_fields = Set.new
      data.each do |key, value|
        @attrs[key.to_sym] = process_value(value)
      end
      new_attrs(*data.keys)
    end

    def each(&block)
      @attrs.each(&block)
    end

    def [](method)
      send(method.to_sym)
    rescue NoMethodError
      nil
    end

    def []=(method, value)
      send("#{method}=", value)
    rescue NoMethodError
      nil
    end

    def key?(key)
      @_fields.include?(key)
    end
    alias_method :has_key?, :key?
    alias_method :include?, :key?

    def inspect
      (to_attrs.respond_to?(:pretty_inspect) ? to_attrs.pretty_inspect : to_attrs.inspect)
    end

    alias_method :to_s, :inspect

    def to_attrs
      hash = attrs.clone
      hash.keys.each do |k|
        if hash[k].is_a?(Resource)
          hash[k] = hash[k].to_attrs
        elsif hash[k].is_a?(Array) && hash[k].all? { |el| el.is_a?(Resource) }
          hash[k] = hash[k].collect(&:to_attrs)
        end
      end
      hash
    end

    def update(attributes)
      attributes.each do |key, value|
        send("#{key}=", value)
      end
    end

    private

    def process_value(value)
      case value
      when Hash then self.class.new(value)
      when Array then value.map { |v| process_value(v) }
      else cast_value_type(value)
      end
    end

    ATTR_SETTER    = "=".freeze
    ATTR_PREDICATE = "?".freeze

    def method_missing(method, *args)
      attr_name, suffix = method.to_s.scan(/([a-z0-9\_]+)(\?|\=)?$/i).first
      if suffix == ATTR_SETTER
        setter_missing(attr_name, args.first)
      elsif attr_name && @_fields.include?(attr_name.to_sym)
        getter_missing(attr_name, suffix)
      elsif suffix.nil? && SPECIAL_METHODS.include?(attr_name)
        instance_variable_get "@_#{attr_name}"
      elsif attr_name && !@_fields.include?(attr_name.to_sym)
        nil
      else
        super
      end
    end

    def new_attrs(*names)
      names.map { |n| new_attr(n) }
    end

    def new_attr(name)
      name = name.to_sym
      @_fields << name
      unless respond_to?(name)
        define_singleton_method(name) { @attrs[name] }
        define_singleton_method("#{name}=") { |v| @attrs[name] = v }
        define_singleton_method("#{name}?") { !!@attrs[name] }
      end
      name
    end

    def setter_missing(attr_name, value)
      new_attr(attr_name)
      send("#{attr_name}=", value)
    end

    def getter_missing(attr_name, suffix)
      value = @attrs[attr_name.to_sym]
      case suffix
      when nil
        new_attr(attr_name)
        value
      when ATTR_PREDICATE then !!value
      end
    end

    # rubocop:disable Metrics/LineLength
    ISO8601 = %r{^(-?(?:[1-9][0-9]*)?[0-9]{4})-(1[0-2]|0[1-9])-(3[01]|0[1-9]|[12][0-9])T(2[0-3]|[01][0-9]):([0-5][0-9]):([0-5][0-9])(\.[0-9]+)?(Z|[+-](?:2[0-3]|[01][0-9]):[0-5][0-9])?$}.freeze
    # rubocop:enable Metrics/LineLength
    def cast_value_type(value)
      case value
      when ISO8601 then DateTime.parse(value)
      else value
      end
    rescue
      value
    end
  end
end
