module Tacokit
  class Member < Resource

    def fetch(options = {})
      update client.member(self.username, options)
    end

    def sync(options = {})
      update client.update_member(self.username, to_attrs.merge(options))
    end

    def fetch_field(field)
      client.member_field(self.username, field).tap do |res|
        self.update field => res
      end
    end

    def fetch_relation(relation, options = {})
      client.member_resource(self.username, relation).tap do |res|
        self.update relation => res
      end
    end

  end
end
