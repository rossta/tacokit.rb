module Tacokit
  class Client
    module Boards
      # Retrieve a board
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id
      def board(board_id, options = nil)
        get board_path(board_id), options
      end

      # Retrieve a board's actions
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-actions
      def board_actions(board_id, options = {})
        board_resource(board_id, "actions", options)
      end

      # Retrieve a board's stars
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-boardstars
      def board_stars(board_id, options = {})
        board_resource(board_id, "board_stars", options)
      end

      # Retrieve a board's cards
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-cards
      def board_cards(board_id, options = {})
        board_resource(board_id, "cards", options)
      end

      # Retrieve a board's checklists
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-checklists
      def board_checklists(board_id, options = {})
        board_resource(board_id, "checklists", options)
      end

      # Retrieve a board's labels
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-labels
      def board_labels(board_id, options = {})
        board_resource(board_id, "labels", options)
      end

      # Retrieve a board's lists
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-lists
      def lists(board_id, options = {})
        board_resource(board_id, "lists", options)
      end
      alias_method :board_lists, :lists

      # Retrieve a board's members
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-members
      def board_members(board_id, options = {})
        board_resource(board_id, "members", options)
      end

      # Retrieve your preferences for a board
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-myprefs
      def board_preferences(board_id, options = {})
        board_resource(board_id, "my_prefs", options)
      end

      # Retrieve a board's organization
      #
      # @see https://trello.com/docs/api/board/index.html#get-1-boards-board-id-organization
      def board_organization(board_id, options = {})
        board_resource(board_id, "organization", options)
      end

      # Update board attributes
      #
      # @see https://trello.com/docs/api/board/index.html#put-1-boards-board-id
      def update_board(board_id, options = {})
        put board_path(board_id), options
      end

      # Add a member to a board
      #
      # @see https://trello.com/docs/api/board/index.html#put-1-boards-board-id-members-idmember
      def add_board_member(board_id, email, full_name, options = {})
        options.update \
          email: email,
          full_name: full_name
        put board_path(board_id, "members"), options
      end

      # Update a board member's type
      #
      # @see https://trello.com/docs/api/board/index.html#put-1-boards-board-id-members-idmember
      def update_board_member(board_id, member_id, type)
        update_board_resource(board_id, "members", member_id, type: type)
      end

      # POST /1/boards
      def create_board(name, options = {})
        post board_path, options.merge(name: name)
      end

      private

      def create_board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        post board_path(board_id, *paths), options
      end

      def update_board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        put board_path(board_id, *paths), options
      end

      def board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get board_path(board_id, *paths), options
      end

      def board_path(*paths)
        path_join("boards", *paths)
      end
    end
  end
end
