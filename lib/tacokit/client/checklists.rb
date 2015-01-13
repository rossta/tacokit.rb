module Tacokit
  class Client
    module Checklists

      # Retrieve a checklist
      #
      # @see https://trello.com/docs/api/checklist/index.html#get-1-checklists-idchecklist
      def checklist(checklist_id, options = nil)
        get checklist_path(checklist_id), options
      end

      # Retrieve a checklist's field
      #
      # @see https://trello.com/docs/api/checklist/index.html#get-1-checklists-idchecklist-field
      def checklist_field(checklist_id, field)
        get checklist_path(checklist_id, camp(field))
      end

      # Retrieve the checklist's board
      #
      # @see https://trello.com/docs/api/checklist/index.html#get-1-checklists-idchecklist-board
      def checklist_board(checklist_id, options = {})
        checklist_resource 'board', options
      end

      # Retrieve a checklist's card
      #
      # @see https://trello.com/docs/api/checklist/index.html#get-1-checklists-idchecklist-cards
      def checklist_card(checklist_id, options = {})
        checklist_resource 'card', options
      end

      # Retrieve a checklist's check items
      #
      # @see https://trello.com/docs/api/checklist/index.html#get-1-checklists-idchecklist-checkitems
      def checklist_check_items(checklist_id, options = {})
        checklist_resource 'check_items', options
      end

      def checklist_resource(checklist_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get checklist_path(checklist_id, *paths), options
      end

      # Updates a checklist
      #
      # @see https://trello.com/docs/api/checklist/index.html#put-1-checklists-idchecklist
      def update_checklist(checklist_id, options = {})
        put checklist_path(checklist_id), options
      end

      # Create a checklist
      #
      # @see https://trello.com/docs/api/checklist/index.html#post-1-checklists
      def create_checklist(card_id, name, options = {})
        options.update card_id: card_id, name: name
        post checklist_path, options
      end

      # Add a checklist item to a checklist
      #
      # @see https://trello.com/docs/api/checklist/index.html#post-1-checklists-idchecklist-checkitems
      def add_checklist_item(checklist_id, name, options = {})
        post checklist_path(checklist_id, 'checkItems'), options.merge(name: name)
      end

      # Delete a checklist
      #
      # @see https://trello.com/docs/api/checklist/index.html#delete-1-checklists-idchecklist
      def delete_checklist(checklist_id)
        delete checklist_path(checklist_id)
      end

      # DELETE /1/checklists/[idChecklist]/checkItems/[idCheckItem]

      def checklist_path(*paths)
        path_join("checklists", *paths)
      end
    end
  end
end
