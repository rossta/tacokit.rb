module Tacokit
  class Client
    module Boards

      # GET /1/boards/[board_id]
      def board(board_id, options = nil)
        get board_path(board_id), options
      end

      # GET /1/boards/[board_id]/[field]
      def board_field(board_id, field, options = nil)
        get board_path(board_id, camp(field)), options
      end

      # GET /1/boards/[board_id]/[resource]
      # actions
      # boardStars
      # cards
      # cards/[filter]
      # cards/[idCard]
      # checklists
      # deltas
      # labels
      # labels/[idLabel]
      # lists
      # lists/[filter]
      # members
      # members/[filter]
      # members/[idMember]/cards
      # membersInvited
      # membersInvited/[field]
      # memberships
      # memberships/[idMembership]
      # myPrefs
      # organization
      # organization/[field]
      def board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get board_path(board_id, *paths), options
      end

      # PUT /1/boards/[board_id]
      def update_board(board_id, options = {})
        put board_path(board_id), options
      end

      # POST /1/boards
      def create_board(name, options = {})
        post board_path, options.merge(name: name)
      end

      # PUT /1/boards/[board_id]/[field]
      # closed
      # desc
      # idOrganization
      # labelNames/blue
      # labelNames/green
      # labelNames/orange
      # labelNames/purple
      # labelNames/red
      # labelNames/yellow
      # myPrefs/emailPosition
      # myPrefs/idEmailList
      # myPrefs/showListGuide
      # myPrefs/showSidebar
      # myPrefs/showSidebarActivity
      # myPrefs/showSidebarBoardActions
      # myPrefs/showSidebarMembers
      # name
      # prefs/background
      # prefs/calendarFeedEnabled
      # prefs/cardAging
      # prefs/cardCovers
      # prefs/comments
      # prefs/invitations
      # prefs/permissionLevel
      # prefs/selfJoin
      # prefs/voting
      # subscribed
      def update_board_field(board_id, *paths)
        value = paths.pop
        put board_path(board_id, camel_join(*paths)), value: value
      end

      # PUT /1/boards/[board_id]/[resource]
      # members
      # members/[idMember]
      # memberships/[idMembership]

      # POST /1/boards/[board_id]/[resource]
      # calendarKey/generate
      # checklists
      # emailKey/generate
      # labels
      # lists
      # markAsViewed
      # powerUps
      def create_board_resource(board_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        post board_path(board_id, *paths), options
      end

      # DELETE /1/boards/[board_id]/[resource]/[resource_id]
      # members/[idMember]
      # powerUps/[powerUp]
      #

      def board_path(*paths)
        path_join("boards", *paths)
      end

    end
  end
end
