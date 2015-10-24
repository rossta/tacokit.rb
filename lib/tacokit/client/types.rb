module Tacokit
  class Client
    module Types
      # Get a resource type
      #
      # @see https://developers.trello.com/advanced-reference/type#get-1-types-id
      def type(model_id)
        get resource_path "types", model_id
      end
    end
  end
end
