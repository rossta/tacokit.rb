module Tacokit
  class Member < Resource

    def fetch(options = {})
      update client.member(self.username, options)
    end

    def save(options = {})
      update client.update_member(self.username, to_attrs.merge(options))
    end

    def update(attributes)
      attributes.each do |key, value|
        self.send("#{key}=", value)
      end
    end
  end
end
