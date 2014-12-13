module Tacokit
  class Client
    module Members

      def member(username = 'me', options = nil)
        get "members/#{username}", options
      end

      def member_field(username, field, options = nil)
        (get "members/#{username}/#{field.camelize(:lower)}", options)['_value']
      end

    end
  end
end
