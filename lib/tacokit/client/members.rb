module Tacokit
  class Client
    module Members
      # Retrieve a Trello member
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username
      def member(username = "me", options = nil)
        get member_path(username), options
      end

      # Retrieve a member's actions
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-actions
      def actions(username = "me", options = {})
        get member_path(username, "actions"), options
      end
      alias_method :member_actions, :actions

      # Retrieve a member's boards
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-boards
      def boards(username = "me", options = {})
        get member_path(username, "boards"), options
      end

      # Retrieve a member's cards
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-cards
      def cards(username = "me", options = {})
        get member_path(username, "cards"), options
      end

      # Retrieve a member's notifications
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-notifications
      def notifications(username = "me", options = {})
        get member_path(username, "notifications"), options
      end

      # Retrieve a member's organizations
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-organizations
      def organizations(username = "me", options = {})
        get member_path(username, "organizations"), options
      end

      # Retrieve a member's tokens
      #
      # @see https://trello.com/docs/api/member/index.html#get-1-members-idmember-or-username-tokens
      def tokens(username = "me", options = {})
        get member_path(username, "tokens"), options
      end

      # Update a member
      #
      # @see https://trello.com/docs/api/member/index.html#put-1-members-idmember-or-username
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

      def member_path(*paths)
        path_join "members", *paths
      end
    end
  end
end
