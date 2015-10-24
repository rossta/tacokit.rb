module Tacokit
  class Client
    module Checklists
      # Retrieve a checklist
      #
      # @see https://developers.trello.com/advanced-reference/checklist#get-1-checklists-idchecklist
      def checklist(checklist_id, options = nil)
        get checklist_path(checklist_id), options
      end

      # Retrieve the checklist's board
      #
      # @see https://developers.trello.com/advanced-reference/checklist#get-1-checklists-idchecklist-board
      def checklist_board(checklist_id, options = {})
        checklist_resource checklist_list_id, "board", options
      end

      # Retrieve a checklist's card
      #
      # @see https://developers.trello.com/advanced-reference/checklist#get-1-checklists-idchecklist-cards
      def checklist_card(checklist_id, options = {})
        checklist_resource checklist_id, "card", options
      end

      # Retrieve a checklist's check items
      #
      # @see https://developers.trello.com/advanced-reference/checklist#get-1-checklists-idchecklist-checkitems
      def check_items(checklist_id, options = {})
        checklist_resource checklist_id, "check_items", options
      end
      alias_method :checklist_check_items, :check_items

      # Updates a checklist
      #
      # @see https://developers.trello.com/advanced-reference/checklist#put-1-checklists-idchecklist
      def update_checklist(checklist_id, options = {})
        put checklist_path(checklist_id), options
      end
      alias_method :checklist_update, :update_checklist

      # Create a checklist
      #
      # @see https://developers.trello.com/advanced-reference/checklist#post-1-checklists
      def create_checklist(card_id, name, options = {})
        options.update card_id: card_id, name: name
        post "checklists", options
      end
      alias_method :checklist_create, :create_checklist

      # Add a checklist item to a checklist
      #
      # @see https://developers.trello.com/advanced-reference/checklist#post-1-checklists-idchecklist-checkitems
      def add_checklist_check_item(checklist_id, name, options = {})
        post checklist_path(checklist_id, "checkItems"), options.merge(name: name)
      end
      alias_method :checklist_check_item_create, :add_checklist_check_item
      alias_method :add_checklist_item, :add_checklist_check_item

      # Delete a checklist
      #
      # @see https://developers.trello.com/advanced-reference/checklist#delete-1-checklists-idchecklist
      def delete_checklist(checklist_id)
        delete checklist_path(checklist_id)
      end
      alias_method :checklist_delete, :delete_checklist

      private

      def checklist_resource(checklist_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get checklist_path(checklist_id, *paths), options
      end

      def checklist_path(checklist_id, *paths)
        resource_path("checklists", checklist_id, *paths)
      end
    end
  end
end
