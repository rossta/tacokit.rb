module Tacokit
  class Client
    # Methods for the Types API
    # @see https://developers.trello.com/advanced-reference/type
    module Types
      # Get a resource type for a given identifier
      # @param model_id [String] the resource identifier
      # @see https://developers.trello.com/advanced-reference/type#get-1-types-id
      def type(model_id)
        get resource_path "types", model_id
      end
    end
  end
end
