module Tacokit
  class Client
    module Members

      def member(username = 'me', options = nil)
        get "members/#{username}", options
      end

      def member_field(username, field, options = nil)
        to_value(get "members/#{username}/#{field.camelize(:lower)}", options)
      end

      def member_actions(username, options = nil)
        get "members/#{username}/actions", options
      end

      private

      def to_value(response_json)
        response_json['_value']
      end

    end
  end
end
