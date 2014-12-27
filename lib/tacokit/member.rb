module Tacokit
  class Member
    include Model

    def self.fetch(client, username, options = {})
      new(client.member(username, options))
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

    def boards=(data)
      super(data.map { |attrs| Board.new(process_value(attrs)) })
    end
  end
end
