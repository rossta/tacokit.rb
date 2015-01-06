module Tacokit
  module Model

    attr_reader :client

    def initialize(client, resource)
      @client   = client
      @resource = resource
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
