module Tacokit
  class Client
    module Lists
      # GET /1/lists/[idList]
      def list(list_id, options = nil)
        get list_path(list_id), options
      end

      # GET /1/lists/[idList]/[field]
      def list_field(list_id, field, options = nil)
        get list_path(list_id, camp(field)), options
      end

      # Retrive a list's actions
      #
      # @see https://trello.com/docs/api/list/index.html#get-1-lists-idlist-actions
      def list_actions(list_id, options = {})
        list_resource list_id, 'actions', options
      end

      # Retrive a list's board
      #
      # @see https://trello.com/docs/api/list/index.html#get-1-lists-idlist-board
      def list_board(list_id, options = {})
        list_resource list_id, 'board', options
      end

      # Retrive a list's cards
      #
      # @see https://trello.com/docs/api/list/index.html#get-1-lists-idlist-cards
      def list_cards(list_id, options = {})
        list_resource list_id, 'cards', options
      end

      # PUT /1/lists/[idList]
      def update_list(list_id, options = {})
        put list_path(list_id), options
      end

      # PUT /1/lists/[idList]/[field]
      # closed
      # idBoard
      # name
      # pos
      # subscribed

      # POST /1/lists
      def create_list(board_id, name, options = {})
        post list_path, options.merge(name: name, board_id: board_id)
      end

      # POST /1/lists/[idList]/[resource]
      # archiveAllCards
      # cards
      # moveAllCards

      private

      def list_path(*paths)
        path_join("lists", *paths)
      end

      def list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get list_path(list_id, *paths), options
      end

    end
  end
end
