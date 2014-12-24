module Tacokit
  class Client
    module Boards

      # GET /1/boards/[board_id]
      def board(board_id, options = nil)
        get "boards/#{board_id}", options
      end

      # GET /1/boards/[board_id]/[field]
      def board_field(board_id, field, options = nil)
        get "boards/#{board_id}/#{to_path(field)}", options
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
      def board_resource(board_id, resource, options = nil)
        get "boards/#{board_id}/#{to_path(resource)}", options
      end

      # PUT /1/boards/[board_id]
      def update_board(board_id, options = {})
        put "boards/#{board_id}", options
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
      # members
      # members/[idMember]
      # memberships/[idMembership]
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

      # POST /1/boards
      def create_board(name, options = {})
        post "boards", options.merge(name: name)
      end

      # POST /1/boards/[board_id]/[resource]
      # calendarKey/generate
      # checklists
      # emailKey/generate
      # labels
      # lists
      # markAsViewed
      # powerUps
      def create_board_resource(board_id, resource, options = {})
        post "boards/#{board_id}/#{to_path(resource)}", options
      end

      # DELETE /1/boards/[board_id]/[resource]/[resource_id]
      # members/[idMember]
      # powerUps/[powerUp]
      def delete_board(board_id)
        delete "boards/#{board_id}"
      end

    end
  end
end
