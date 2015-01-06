module Tacokit
  class Member
    include Tacokit::Model

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

    def boards
      @boards ||= client.as(:boards, Resource[super])
    end

    def boards=(data)
      @boards = nil
      super
    end
  end
end
