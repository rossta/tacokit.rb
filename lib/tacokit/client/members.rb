module Tacokit
  class Client
    module Members

      def member(username)
        get "members/#{username}", { key: app_key }
      end

    end
  end
end
