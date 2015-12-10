module Tacokit
  class Client
    # Methods for the Members API
    # @see https://developers.trello.com/advanced-reference/member
    module Members
      # @overload member(username = "me", options = nil)
      #   Retrieve a Trello member by username
      #   @param username [String] the member's username
      #   @param options [Hash] the options to fetch the member with
      #   @return [Tacokit::Resource<Member>] the member resource
      # @overload member(options)
      #   Retrieve the current member
      #   @param options [Hash] the options to fetch the member with
      #   @return [Tacokit::Resource<Member>] the member resource
      # @example fetch the current member
      #   Tacokit.member #=> Tacokit::Resource<Member>
      # @example fetch the current member with all boards
      #   Tacokit.member(boards: "all") #=> Tacokit::Resource<Member>
      # @example fetch the member named 'rossta'
      #   Tacokit.member("tacokit") #=> Tacokit::Resource<Member>
      # @example configure a local client and fetch different current member
      #   client = Tacokit::Client.new app_key: "another-app-key"
      #   client.member #=> Tacokit::Resource<Member>
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username
      def member(username = "me", options = nil)
        username, options = extract_member_args(username, options)
        get member_path(username), options
      end

      # @overload actions(username = "me", options = nil)
      #   Retrieve a member's actions
      #   @param username [String, Tacokit::Resource<Member>] the username or member resource
      #   @param options [Hash] the options to fetch the actions with
      #   @return [Tacokit::Collection] the action resources
      # @overload actions(options = nil)
      #   Retrieve the current member's actions
      #   @param options [Hash] the options to fetch the actions with
      #   @return [Tacokit::Collection] the action resources
      # @example fetch the current member's actions
      #   Tacokit.actions #=> Tacokit::Collection<Action>
      # @example fetch the current member with only card comment actions; use "commentCard" or "card_comment" as option value
      #   Tacokit.actions(filter: "comment_card") #=> Tacokit::Collection<Action>
      # @example fetch the actions for the member named 'tacokit'
      #   Tacokit.actions("tacokit") #=> Tacokit::Collection<Member>
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-actions
      def actions(username = "me", options = {})
        username, options = extract_member_args(username, options)
        paginated_get member_path(username, "actions"), options
      end
      alias_method :member_actions, :actions

      # Retrieve a member's boards
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the options to fetch the boards with
      # @return [Tacokit::Resource] the boards collection
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-boards
      def boards(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "boards"), options
      end

      # Retrieve a member's cards
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the options to fetch the cards with
      # @return [Tacokit::Resource] the cards collection
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-cards
      def cards(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "cards"), options
      end

      # Retrieve a member's notifications
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the options to fetch the notifications with
      # @return [Tacokit::Resource] the notifications collection
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-notifications
      def notifications(username = "me", options = {})
        username, options = extract_member_args(username, options)
        paginated_get member_path(username, "notifications"), options
      end

      # Retrieve a member's organizations
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the options to fetch the organizations with
      # @return [Tacokit::Resource] the organizations collection
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-organizations
      def organizations(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "organizations"), options
      end

      # Retrieve a member's tokens
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the options to fetch the tokens with
      # @return [Tacokit::Resource] the tokens collection
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-tokens
      def tokens(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "tokens"), options
      end

      # Update a member
      # @param username [String, Tacokit::Resource<Member>] the username or member resource
      # @param options [Hash] the attributes to update on the list
      # @see https://developers.trello.com/advanced-reference/member#put-1-members-idmember-or-username
      def update_member(username, options = {})
        put member_path(username), options
      end

      private

      def member_resource(username, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get(member_path(username, *paths), options)
      end

      def member_path(member_id, *paths)
        resource_path("members", member_id, *paths)
      end

      def extract_member_args(username, options)
        options, username = username, "me" if username.is_a?(Hash)
        [username, options]
      end
    end
  end
end
