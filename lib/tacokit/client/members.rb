module Tacokit
  class Client
    module Members

      def member(username = 'me')
        get "members/#{username}"
      end

    end
  end
end
