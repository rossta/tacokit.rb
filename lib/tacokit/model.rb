module Tacokit
  module Model

    def initialize(resource)
      @resource = resource
    end

    def client
      @resource._client
    end

    def inspect
      @resource.inspect
    end

    def to_s
      @resource.to_s
    end

    def method_missing(method, *args)
      @resource.send(method, *args)
    end

  end
end
