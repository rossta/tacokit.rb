module Tacokit
  class Client
    # Methods for the Boards API
    # @see https://developers.trello.com/advanced-reference/board
    module Boards
      # Retrieve a board
      # @param board_id [String] the board identifier
      # @return [Tacokit::Resource<Board>] the board resource
      # @example fetch a board
      #   Tacokit.board("aBoardId") #=> Tacokit::Resource<Board>
      # @example fetch a board with all its cards
      #   Tacokit.member("aBoardId", cards: "all") #=> Tacokit::Resource<Board>
      # @example configure a local client, fetch a board with a subset of attributes
      #   client = Tacokit::Client.new app_key: "another-app-key"
      #   client.board('aBoardId', fields: %w[name shortUrl desc]) #=> Tacokit::Resource<Board>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id
      def board(board_id, options = nil)
        get board_path(board_id), options
      end

      # Retrieve a board's actions
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the actions with
      # @return [Tacokit::Collection<Action>] the action resources
      # @example fetch "create card" actions for a given board
      #   Tacokit.board_actions("aBoardId", filter: "create_card") #=> Tacokit::Collection<Action>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-actions
      def board_actions(board_id, options = {})
        paginated_board_resource(board_id, "actions", options)
      end

      # Retrieve a board's stars
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the stars with
      # @return [Tacokit::Collection<Star>] the star resources
      # @example fetch board stars
      #   Tacokit.board_stars("aBoardId") #=> Tacokit::Collection<Star>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-boardstars
      def board_stars(board_id, options = {})
        board_resource(board_id, "board_stars", options)
      end

      # Retrieve a board's cards
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the cards with
      # @return [Tacokit::Collection<Card>] the card resources
      # @example fetch board cards
      #   Tacokit.board_cards("aBoardId") #=> Tacokit::Collection<Card>
      # @example fetch board cards with attachments, members, stickers
      #   Tacokit.board_cards("aBoardId", attachments: true, members: true, stickers: true) #=> Tacokit::Collection<Card>
      # @example configure a local client, fetch a board"s cards with a subset of attributes
      #   client = Tacokit::Client.new app_key: "another-app-key"
      #   client.board_cards("aBoardId") #=> Tacokit::Resource<Card>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-cards
      def board_cards(board_id, options = {})
        paginated_board_resource(board_id, "cards", options)
      end

      # Retrieve a board's checklists
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the checklists with
      # @return [Tacokit::Collection<Checklist>] the checklist resources
      # @example fetch board checklists
      #   Tacokit.board_checklists("aBoardId") #=> Tacokit::Collection<Checklist>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-checklists
      def board_checklists(board_id, options = {})
        board_resource(board_id, "checklists", options)
      end

      # Retrieve a board's labels
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the labels with
      # @return [Tacokit::Collection<Label>] the label resources
      # @example fetch board's first 50 (default) labels
      #   Tacokit.board_labels("aBoardId") #=> Tacokit::Collection<Label>
      # @example fetch board's first 100 labels
      #   Tacokit.board_labels("aBoardId", limit: 100) #=> Tacokit::Collection<Label>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-labels
      def board_labels(board_id, options = {})
        board_resource(board_id, "labels", options)
      end

      # Retrieve a board's lists
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the lists with
      # @return [Tacokit::Collection<List>] the list resources
      # @example fetch open board lists
      #   Tacokit.board_lists("aBoardId") #=> Tacokit::Collection<List>
      # @example fetch all board lists with open cards
      #   Tacokit.board_lists("aBoardId", filter: "all", cards: "open") #=> Tacokit::Collection<List>
      # @example configure a local client, fetch a board's open lists with lists names and pos
      #   client = Tacokit::Client.new app_key: "another-app-key"
      #   client.board_lists("aBoardId", fields: %w[name pos]) #=> Tacokit::Resource<List>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-lists
      def lists(board_id, options = {})
        board_resource(board_id, "lists", options)
      end
      alias_method :board_lists, :lists

      # Retrieve a board's members
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the members with
      # @return [Tacokit::Collection<Member>] the member resources
      # @example fetch board's members
      #   Tacokit.board_members("aBoardId") #=> Tacokit::Collection<Member>
      # @example fetch board's members with selected attributes
      #   Tacokit.board_members("aBoardId", fields: %w[username url avatar_hash]) #=> Tacokit::Collection<Member>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-members
      def board_members(board_id, options = {})
        board_resource(board_id, "members", options)
      end

      # Retrieve your preferences for a board
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the preferences with
      # @return [Tacokit::Collection] the preference resources
      # @example fetch board's preferences
      #   Tacokit.board_preferences("aBoardId") #=> Tacokit::Collection<Preference>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-myprefs
      def board_preferences(board_id, options = {})
        board_resource(board_id, "my_prefs", options)
      end

      # Retrieve a board's organization
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the options to fetch the organizations with
      # @return [Tacokit::Collection] the organization resources
      # @example fetch board's organization
      #   Tacokit.board_organization("aBoardId") #=> Tacokit::Resource<Organization>
      # @example fetch board's organization with selected attributes
      #   Tacokit.board_organization("aBoardId", fields: %w[name url website]) #=> Tacokit::Resource<Organization>
      # @see https://developers.trello.com/advanced-reference/board#get-1-boards-board-id-organization
      def board_organization(board_id, options = {})
        board_resource(board_id, "organization", options)
      end

      # Update board attributes
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param options [Hash] the attributes to update on the board
      # @example Update a board's name and description
      #   Tacokit.update_board("aBoardId", name: "New Board Name", desc: "For realz this time")
      # @example Open a closed board
      #   Tacokit.update_board("aBoardId", closed: false)
      # @see https://developers.trello.com/advanced-reference/board#put-1-boards-board-id
      def update_board(board_id, options = {})
        put board_path(board_id), options
      end

      # Add a member to a board
      # @param board_id [String, Tacokit::Resource<Board>] the board identifier or board
      # @param email [String] an email address of the member to add
      # @param full_name [String] the full name of the member to add
      # @param options [Hash] options to modify the membership with
      # @example Add your friend Susan as an admin to your board
      #   Tacokit.add_board_member("aBoardId", "susan@example.com", "Susan Example", type: "admin")
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
      # @example Demote your friend Larry to a member with "normal" membership privileges
      #   Tacokit.update_board_member("aBoardId", "larrysMemberIdentifier", "normal")
      # @see https://developers.trello.com/advanced-reference/board#put-1-boards-board-id-members-idmember
      def update_board_member(board_id, member_id, type)
        update_board_resource(board_id, "members", member_id, type: type)
      end

      # Create a board
      # @param name [String] the new board name
      # @param options [Hash] options to create the board with
      # @example Create a board named "Holiday Shopping"
      #   Tacokit.create_board("Holiday Shopping")
      # @example Create a board named "Project B" copied from another board with a new organization and description
      #   Tacokit.create_board("Project B", board_source_id: "projectASourceIdentifier", organization_id: "anOrgId", desc: "A cloned board!")
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
