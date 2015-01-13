module Tacokit
  class Client
    module Actions

      # Retrieve an action
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction
      def action(action_id, options = nil)
        get action_path(action_id), options
      end

      # Retrieve an action's field
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-field
      def action_field(action_id, field)
        get action_path(action_id, camp(field))
      end

      # GET /1/actions/[idAction]/[resource]
      # board
      # board/[field]
      # card
      # card/[field]
      # entities
      # list
      # list/[field]
      # member
      # member/[field]
      # memberCreator
      # memberCreator/[field]
      # organization
      # organization/[field]

      # Retrieve an action's board
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-field
      def action_board(action_id, fields = 'all')
        action_resource action_id, 'board', fields: fields
      end

      # Retrieve an actions' card
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-card
      def action_card(action_id, fields = 'all')
        action_resource action_id, 'card', fields: fields
      end

      # Retrive an action's entities
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-entities
      def action_entities(action_id)
        action_resource action_id, 'entities'
      end

      # Retrieve an action's list
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-list
      def action_list(action_id, fields = 'all')
        action_resource action_id, 'list', fields: fields
      end

      # Retrieve an actions' member
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-member
      def action_member(action_id, fields = 'all')
        action_resource action_id, 'member', fields: fields
      end

      # Retrieve an action's creator
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-membercreator
      def action_member_creator(action_id, fields = 'all')
        action_resource action_id, 'memberCreator', fields: fields
      end

      # Retrieve an action's org
      #
      # @see https://trello.com/docs/api/action/index.html#get-1-actions-idaction-organization
      def action_organization(action_id, fields = 'all')
        action_resource action_id, 'organization', fields: fields
      end

      # Update an action
      #
      # @see https://trello.com/docs/api/action/index.html#put-1-actions-idaction
      def update_action(action_id, options = {})
        put action_path(action_id), options
      end

      # Set new text for an action
      #
      # @see https://trello.com/docs/api/action/index.html#put-1-actions-idaction-text
      def update_action_text(action_id, text)
        put action_path(action_id, 'text'), value: text
      end
      alias edit_action_text update_action_text

      # Delete an action
      #
      # @see https://trello.com/docs/api/action/index.html#delete-1-actions-idaction
      def delete_action(action_id)
        delete action_path(action_id)
      end

      def action_resource(action_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get action_path(action_id, *paths), options
      end

      def action_path(*paths)
        path_join("actions", *paths)
      end
    end
  end
end
