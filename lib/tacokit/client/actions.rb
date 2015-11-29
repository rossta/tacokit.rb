module Tacokit
  class Client
    module Actions
      # Retrieve an action
      # @param action_id [String] the action identifier
      # @return [Tacokit::Resource] the action resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction
      def action(action_id, options = nil)
        get action_path(action_id), options
      end

      # Retrieve an action's board
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of board attributes to fetch
      # @return [Tacokit::Resource] the board resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-field
      def action_board(action_id, fields = "all")
        action_resource action_id, "board", fields: fields
      end

      # Retrieve an actions" card
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of card attributes to fetch
      # @return [Tacokit::Resource] the card resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-card
      def action_card(action_id, fields = "all")
        action_resource action_id, "card", fields: fields
      end

      # Retrive an action's entities
      # @param action_id [String] the action identifier
      # @return [Array] list of entity attributes involved in the action
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-entities
      def action_entities(action_id)
        action_resource action_id, "entities"
      end

      # Retrieve an action's list
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of list attributes to fetch
      # @return [Tacokit::Resource] the list resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-list
      def action_list(action_id, fields = "all")
        action_resource action_id, "list", fields: fields
      end

      # Retrieve an action's member
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of member attributes to fetch
      # @return [Tacokit::Resource] the member resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-member
      def action_member(action_id, fields = "all")
        action_resource action_id, "member", fields: fields
      end

      # Retrieve an action's creator
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of member attributes to fetch
      # @return [Tacokit::Resource] the member resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-membercreator
      def action_member_creator(action_id, fields = "all")
        action_resource action_id, "memberCreator", fields: fields
      end

      # Retrieve an action's organization
      # @param action_id [String] the action identifier
      # @param fields [String, Array<String>] a list of organization attributes to fetch
      # @return [Tacokit::Resource] the organization resource
      # @see https://developers.trello.com/advanced-reference/action#get-1-actions-idaction-organization
      def action_organization(action_id, fields = "all")
        action_resource action_id, "organization", fields: fields
      end

      # Update an action
      # @param action_id [String] the action identifier
      # @param options [Hash] a hash of attributes to update
      # @see https://developers.trello.com/advanced-reference/action#put-1-actions-idaction
      def update_action(action_id, options = {})
        put action_path(action_id), options
      end

      # Set new text for an action
      #
      # @see https://developers.trello.com/advanced-reference/action#put-1-actions-idaction-text
      def update_action_text(action_id, text)
        put action_path(action_id, "text"), value: text
      end
      alias_method :edit_action_text, :update_action_text

      # Delete an action
      #
      # @see https://developers.trello.com/advanced-reference/action#delete-1-actions-idaction
      def delete_action(action_id)
        delete action_path(action_id)
      end

      private

      def action_resource(action_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get action_path(action_id, *paths), options
      end

      def action_path(action_id, *paths)
        resource_path("actions", action_id, *paths)
      end
    end
  end
end
