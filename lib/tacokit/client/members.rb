module Tacokit
  class Client
    module Members
      # Retrieve a Trello member
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username
      def member(username = "me", options = nil)
        username, options = extract_member_args(username, options)
        get member_path(username), options
      end

      # Retrieve a member's actions
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-actions
      def actions(username = "me", options = {})
        username, options = extract_member_args(username, options)
        paginated_get member_path(username, "actions"), options
      end
      alias_method :member_actions, :actions

      # Retrieve a member's boards
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-boards
      def boards(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "boards"), options
      end

      # Retrieve a member's cards
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-cards
      def cards(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "cards"), options
      end

      # Retrieve a member's notifications
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-notifications
      def notifications(username = "me", options = {})
        username, options = extract_member_args(username, options)
        paginated_get member_path(username, "notifications"), options
      end

      # Retrieve a member's organizations
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-organizations
      def organizations(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "organizations"), options
      end

      # Retrieve a member's tokens
      #
      # @see https://developers.trello.com/advanced-reference/member#get-1-members-idmember-or-username-tokens
      def tokens(username = "me", options = {})
        username, options = extract_member_args(username, options)
        get member_path(username, "tokens"), options
      end

      # Update a member
      #
      # @see https://developers.trello.com/advanced-reference/member#put-1-members-idmember-or-username
      def update_member(username, options = {})
        put member_path(username), options
      end

      # PUT /1/members/[idMember or username]/[field]
      # avatarSource
      # fullName
      # initials
      # username
      # boardBackgrounds/[idBoardBackground]
      # boardStars/[idBoardStar]
      # boardStars/[idBoardStar]/idBoard
      # boardStars/[idBoardStar]/pos
      # customBoardBackgrounds/[idBoardBackground]
      # prefs/colorBlind
      # prefs/minutesBetweenSummaries
      # savedSearches/[idSavedSearch]
      # savedSearches/[idSavedSearch]/name
      # savedSearches/[idSavedSearch]/pos
      # savedSearches/[idSavedSearch]/query

      # DELETE /1/members/[idMember or username]/[resource]/[resource_id]
      # boardBackgrounds/[idBoardBackground]
      # boardStars/[idBoardStar]
      # customBoardBackgrounds/[idBoardBackground]
      # customStickers/[idCustomSticker]
      # savedSearches/[idSavedSearch]

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
