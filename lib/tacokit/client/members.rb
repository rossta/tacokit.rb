module Tacokit
  class Client
    module Members

      def member(username = 'me', options = nil)
        get "members/#{username}", options
      end

    end
  end
end
