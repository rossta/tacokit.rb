module Tacokit
  class Member

    def initialize(resource)
      @resource = resource
    end

    def method_missing(method, *args)
      @resource.send(method, *args)
    end

    def client
      @resource._client
    end

    def fetch(options = {})
      update client.member(username, options)
    end

    def sync(options = {})
      update client.update_member(username, to_attrs.merge(options))
    end

    def fetch_field(field)
      client.member_field(username, field).tap do |res|
        update field => res
      end
    end

    def fetch_relation(relation, options = {})
      client.member_resource(username, relation).tap do |res|
        update relation => res
      end
    end

  end
end
