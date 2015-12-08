module Tacokit
  class Client
    # Methods for the Boards API
    # @see https://developers.trello.com/advanced-reference/board
    module Boards
      # Retrieve a board
      # @param board_id [String] the board identifier
      # @return [Tacokit::Resource] the board resource
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id
      def board(board_id, options = nil)
        get board_path(board_id), options
      end

      # Retrieve a board's actions
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the actions with
      # @return [Tacokit::Collection] the action resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-actions
      def board_actions(board_id, options = {})
        paginated_board_resource(board_id, "actions", options)
      end

      # Retrieve a board's stars
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the stars with
      # @return [Tacokit::Collection] the star resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-boardstars
      def board_stars(board_id, options = {})
        board_resource(board_id, "board_stars", options)
      end

      # Retrieve a board's cards
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the cards with
      # @return [Tacokit::Collection] the card resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-cards
      def board_cards(board_id, options = {})
        paginated_board_resource(board_id, "cards", options)
      end

      # Retrieve a board's checklists
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the checklists with
      # @return [Tacokit::Collection] the checklist resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-checklists
      def board_checklists(board_id, options = {})
        board_resource(board_id, "checklists", options)
      end

      # Retrieve a board's labels
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the labels with
      # @return [Tacokit::Collection] the label resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-labels
      def board_labels(board_id, options = {})
        board_resource(board_id, "labels", options)
      end

      # Retrieve a board's lists
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the lists with
      # @return [Tacokit::Collection] the list resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-lists
      def lists(board_id, options = {})
        board_resource(board_id, "lists", options)
      end
      alias_method :board_lists, :lists

      # Retrieve a board's members
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the members with
      # @return [Tacokit::Collection] the member resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-members
      def board_members(board_id, options = {})
        board_resource(board_id, "members", options)
      end

      # Retrieve your preferences for a board
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the preferences with
      # @return [Tacokit::Collection] the preference resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-myprefs
      def board_preferences(board_id, options = {})
        board_resource(board_id, "my_prefs", options)
      end

      # Retrieve a board's organization
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the organizations with
      # @return [Tacokit::Collection] the organization resources
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-organization
      def board_organization(board_id, options = {})
        board_resource(board_id, "organization", options)
      end

      # Update board attributes
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the attributes to update on the board
      # @see https://developers.trello.com/advanced-reference/board#put-1-boards-board-id
      def update_board(board_id, options = {})
        put board_path(board_id), options
      end

      # Add a member to a board
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param email [String] an email address of the member to add
      # @param full_name [String] the full name of the member to add
      # @param options [Hash] options to modify the membership with
      # @see https://developers.trello.com/advanced-reference/board#put-1-boards-board-id-members-idmember
      def add_board_member(board_id, email, full_name, options = {})
        options.update \
          email: email,
          full_name: full_name
        put board_path(board_id, "members"), options
      end

      # Update a board member's type
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param member_id [String] the member identifier
      # @param type [String] the membership type to change to
      # @see https://developers.trello.com/advanced-reference/board#put-1-boards-board-id-members-idmember
      def update_board_member(board_id, member_id, type)
        update_board_resource(board_id, "members", member_id, type: type)
      end

      # Create a board
      # @param name [String] the new board name
      # @param options [Hash] options to create the board with
      # @see https://developers.trello.com/advanced-reference/board#post-1-boards
      def create_board(name, options = {})
        post "boards", options.merge(name: name)
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

      def paginated_board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        paginated_get board_path(board_id, *paths), options
      end

      def board_path(board_id, *paths)
        resource_path("boards", board_id, *paths)
      end
    end
  end
end
