module Tacokit
  class Client
    module Lists
      # GET /1/lists/[idList]
      def list(list_id, options = nil)
        get "lists/#{list_id}", options
      end

      # GET /1/lists/[idList]/[field]
      # GET /1/lists/[idList]/actions
      # GET /1/lists/[idList]/board
      # GET /1/lists/[idList]/board/[field]
      # GET /1/lists/[idList]/cards
      # GET /1/lists/[idList]/cards/[filter]
      # PUT /1/lists/[idList]
      # PUT /1/lists/[idList]/closed
      # PUT /1/lists/[idList]/idBoard
      # PUT /1/lists/[idList]/name
      # PUT /1/lists/[idList]/pos
      # PUT /1/lists/[idList]/subscribed
      # POST /1/lists
      # POST /1/lists/[idList]/archiveAllCards
      # POST /1/lists/[idList]/cards
      # POST /1/lists/[idList]/moveAllCards
    end
  end
end
