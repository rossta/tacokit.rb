module Tacokit
  class Client
    # Methods for the Lists API
    # @see https://developers.trello.com/advanced-reference/list
    module Lists
      # Retrieve a list by id
      # @param list_id [String] the list identifier or shortlink
      # @return [Tacokit::Resource] the list resource
      # @see https://developers.trello.com/advanced-reference/list#get-1-labels-idlabel-board
      def list(list_id, options = nil)
        get list_path(list_id), options
      end

      # Retrieve list's actions
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the options to fetch the actions with
      # @return [Tacokit::Collection] the action resources
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-actions
      def list_actions(list_id, options = {})
        paginated_list_resource list_id, "actions", options
      end

      # Retrieve a list's board
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the options to fetch the board with
      # @return [Tacokit::Resource] the board resource
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-board
      def list_board(list_id, options = {})
        list_resource list_id, "board", options
      end

      # Retrive a list's cards
      # @param list_id [String, Tacokit::Resource<List>] the list identifier or list
      # @param options [Hash] the options to fetch the cards with
      # @return [Tacokit::Collection] the card resources
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-cards
      def list_cards(list_id, options = {})
        paginated_list_resource list_id, "cards", options
      end

      # Update a list's attributes
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the attributes to update on the list
      # @see https://developers.trello.com/advanced-reference/list#put-1-lists-idlis
      def update_list(list_id, options = {})
        put list_path(list_id), options
      end

      # Create a new list
      # @param board_id [String] the board identifier
      # @param name [String] a name for the list
      # @param options [Hash] options to create the list with
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists
      def create_list(board_id, name, options = {})
        post "lists", options.merge(name: name, board_id: board_id)
      end

      # Archive all cards in a list
      # @param list_id [String, Tacokit::Resource<Card>] the list identifier, shortlink, or list
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def archive_list_cards(list_id)
        post list_path(list_id, camp("archive_all_cards"))
      end

      # Move cards from one list to another
      # @param list_id [String, Tacokit::Resource<List>] the source list identifier or list
      # @param destination_list_id [String, Tacokit::Resource<List>] the destination list identifier
      # @param board_id [String] the board identifier
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def move_list_cards(list_id, destination_list_id, board_id)
        post list_path(list_id, camp("move_all_cards")),
          list_id: destination_list_id, board_id: board_id
      end

      private

      def list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get list_path(list_id, *paths), options
      end

      def paginated_list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        paginated_get list_path(list_id, *paths), options
      end

      def list_path(list_id, *paths)
        resource_path("lists", list_id, *paths)
      end
    end
  end
end
