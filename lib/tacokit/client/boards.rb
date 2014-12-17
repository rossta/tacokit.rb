module Tacokit
  class Client
    module Boards
      # GET /1/boards/[board_id]
      #
      def board(board_id, options = nil)
        get "boards/#{board_id}", options
      end

      # GET /1/boards/[board_id]/[field]
      def board_field(board_id, field, options = nil)
        get "boards/#{board_id}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/boards/[board_id]/actions
      # GET /1/boards/[board_id]/boardStars
      # GET /1/boards/[board_id]/cards
      # GET /1/boards/[board_id]/cards/[filter]
      # GET /1/boards/[board_id]/cards/[idCard]
      # GET /1/boards/[board_id]/checklists
      # GET /1/boards/[board_id]/deltas
      # GET /1/boards/[board_id]/labels
      # GET /1/boards/[board_id]/labels/[idLabel]
      # GET /1/boards/[board_id]/lists
      # GET /1/boards/[board_id]/lists/[filter]
      # GET /1/boards/[board_id]/members
      # GET /1/boards/[board_id]/members/[filter]
      # GET /1/boards/[board_id]/members/[idMember]/cards
      # GET /1/boards/[board_id]/membersInvited
      # GET /1/boards/[board_id]/membersInvited/[field]
      # GET /1/boards/[board_id]/memberships
      # GET /1/boards/[board_id]/memberships/[idMembership]
      # GET /1/boards/[board_id]/myPrefs
      # GET /1/boards/[board_id]/organization
      # GET /1/boards/[board_id]/organization/[field]
      def board_resource(board_id, resource, options = nil)
        get "boards/#{board_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/boards/[board_id]
      # PUT /1/boards/[board_id]/closed
      # PUT /1/boards/[board_id]/desc
      # PUT /1/boards/[board_id]/idOrganization
      # PUT /1/boards/[board_id]/labelNames/blue
      # PUT /1/boards/[board_id]/labelNames/green
      # PUT /1/boards/[board_id]/labelNames/orange
      # PUT /1/boards/[board_id]/labelNames/purple
      # PUT /1/boards/[board_id]/labelNames/red
      # PUT /1/boards/[board_id]/labelNames/yellow
      # PUT /1/boards/[board_id]/members
      # PUT /1/boards/[board_id]/members/[idMember]
      # PUT /1/boards/[board_id]/memberships/[idMembership]
      # PUT /1/boards/[board_id]/myPrefs/emailPosition
      # PUT /1/boards/[board_id]/myPrefs/idEmailList
      # PUT /1/boards/[board_id]/myPrefs/showListGuide
      # PUT /1/boards/[board_id]/myPrefs/showSidebar
      # PUT /1/boards/[board_id]/myPrefs/showSidebarActivity
      # PUT /1/boards/[board_id]/myPrefs/showSidebarBoardActions
      # PUT /1/boards/[board_id]/myPrefs/showSidebarMembers
      # PUT /1/boards/[board_id]/name
      # PUT /1/boards/[board_id]/prefs/background
      # PUT /1/boards/[board_id]/prefs/calendarFeedEnabled
      # PUT /1/boards/[board_id]/prefs/cardAging
      # PUT /1/boards/[board_id]/prefs/cardCovers
      # PUT /1/boards/[board_id]/prefs/comments
      # PUT /1/boards/[board_id]/prefs/invitations
      # PUT /1/boards/[board_id]/prefs/permissionLevel
      # PUT /1/boards/[board_id]/prefs/selfJoin
      # PUT /1/boards/[board_id]/prefs/voting
      # PUT /1/boards/[board_id]/subscribed
      def update_board(board_id, options = {})
        put "boards/#{board_id}", options
      end

      # POST /1/boards
      # POST /1/boards/[board_id]/calendarKey/generate
      # POST /1/boards/[board_id]/checklists
      # POST /1/boards/[board_id]/emailKey/generate
      # POST /1/boards/[board_id]/labels
      # POST /1/boards/[board_id]/lists
      # POST /1/boards/[board_id]/markAsViewed
      # POST /1/boards/[board_id]/powerUps
      # DELETE /1/boards/[board_id]/members/[idMember]
      # DELETE /1/boards/[board_id]/powerUps/[powerUp]

    end
  end
end
