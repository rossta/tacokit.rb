module Tacokit
  class Client
    # Methods for the Lists API
    # @see https://developers.trello.com/advanced-reference/list
    module Lists
      # Retrieve a list by id
      # @param list_id [String] the list identifier or shortlink
      # @return [Tacokit::Resource<List>] the list resource
      # @example Retrieve a list by its id with its open cards
      #   Tacokit.list("aListId", cards: "open") #=> Tacokit::Resource<List>
      # @see https://developers.trello.com/advanced-reference/list#get-1-labels-idlabel-board
      def list(list_id, options = nil)
        get list_path(list_id), options
      end

      # Retrieve list's actions
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the options to fetch the actions with
      # @return [Tacokit::Collection<Action>] the action resources
      # @example fetch "comment" actions for a given list
      #   list = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   Tacokit.list_actions(list, filter: "comment_card") #=> Tacokit::Collection<Action>
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-actions
      def list_actions(list_id, options = {})
        paginated_list_resource list_id, "actions", options
      end

      # Retrieve a list's board
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the options to fetch the board with
      # @return [Tacokit::Resource<Board>] the board resource
      # @example fetch a list's board
      #   list = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   Tacokit.list_board(list) #=> Tacokit::Resource<Board>
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-board
      def list_board(list_id, options = {})
        list_resource list_id, "board", options
      end

      # Retrive a list's cards
      # @param list_id [String, Tacokit::Resource<List>] the list identifier or list
      # @param options [Hash] the options to fetch the cards with
      # @return [Tacokit::Collection<Card>] the card resources
      # @example fetch list cards
      #   list = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   Tacokit.list_cards(list) #=> Tacokit::Collection<Card>
      # @example fetch list cards with attachments, members, stickers
      #   Tacokit.list_cards(list, attachments: true, members: true, stickers: true) #=> Tacokit::Collection<Card>
      # @example configure a local client, fetch a list"s cards with a subset of attributes
      #   client = Tacokit::Client.new app_key: "another-app-key"
      #   client.list_cards(list) #=> Tacokit::Collection<Card>
      # @see https://developers.trello.com/advanced-reference/list#get-1-lists-idlist-cards
      def list_cards(list_id, options = {})
        paginated_list_resource list_id, "cards", options
      end

      # Update a list's attributes
      # @param list_id [String, Tacokit::Resource<List>] the list identifier, shortlink, or list
      # @param options [Hash] the attributes to update on the list
      # @return [Tacokit::Resource<List>] the list resource
      # @example Change a list's name and position
      #   list = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   Tacokit.update_list(list, name: "New Name", pos: "top") #=> Tacokit::Resource<List>
      # @see https://developers.trello.com/advanced-reference/list#put-1-lists-idlis
      def update_list(list_id, options = {})
        put list_path(list_id), options
      end

      # Create a new list
      # @param board_id [String] the board identifier
      # @param name [String] a name for the list
      # @param options [Hash] options to create the list with
      # @return [Tacokit::Resource<List>] the list resource
      # @example Create a new list on the top
      #   board = Tacokit.board("aBoardId")
      #   Tacokit.create_list(board, "New List", pos: "top")  #=> Tacokit::Resource<List>
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists
      def create_list(board_id, name, options = {})
        post "lists", options.merge(name: name, board_id: resource_id(board_id))
      end

      # Archive all cards in a list
      # @param list_id [String, Tacokit::Resource<Card>] the list identifier, shortlink, or list
      # @example Archive cards
      #   list = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   Tacokit.archive_all_cards(list)
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def archive_list_cards(list_id)
        post list_path(list_id, camp("archive_all_cards"))
      end

      # Move cards from one list to another
      # @param list_id [String, Tacokit::Resource<List>] the source list identifier or list
      # @param destination_list_id [String, Tacokit::Resource<List>] the destination list identifier
      # @param board_id [String] the board identifier
      # @example Move cards from list A to B
      #   listA = Tacokit.list("aListId") #=> Tacokit::Resource<List>
      #   listB = Tacokit.list("bListId") #=> Tacokit::Resource<List>
      #   Tacokit.move_all_cards(listA, listB)
      # @see https://developers.trello.com/advanced-reference/list#post-1-lists-idlist-moveallcards
      def move_list_cards(list_id, destination_list_id, board_id = nil)
        board_id ||= resolve_board_id(destination_list_id)
        post list_path(list_id, camp("move_all_cards")),
          list_id: resource_id(destination_list_id), board_id: resource_id(board_id)
      end

      private

      def resolve_board_id(list_id)
        return list_id.board_id if list_id.respond_to?(:board_id)
        return list_id.board.id if list_id.respond_to?(:board)

        raise ArgumentError, "Required option :board_i"
      end

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
