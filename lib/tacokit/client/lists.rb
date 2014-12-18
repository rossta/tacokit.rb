module Tacokit
  class Client
    module Lists
      # GET /1/lists/[idList]
      def list(list_id, options = nil)
        get "lists/#{list_id}", options
      end

      # GET /1/lists/[idList]/[field]
      def list_field(list_id, field, options = nil)
        get "lists/#{list_id}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/lists/[idList]/actions
      # GET /1/lists/[idList]/board
      # GET /1/lists/[idList]/board/[field]
      # GET /1/lists/[idList]/lists
      # GET /1/lists/[idList]/lists/[filter]
      def list_resource(list_id, resource, options = nil)
        get "lists/#{list_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/lists/[idList]
      # PUT /1/lists/[idList]/closed
      # PUT /1/lists/[idList]/idBoard
      # PUT /1/lists/[idList]/name
      # PUT /1/lists/[idList]/pos
      # PUT /1/lists/[idList]/subscribed
      def update_list(list_id, options = {})
        put "lists/#{list_id}", options
      end

      # POST /1/lists
      # POST /1/lists/[idList]/archiveAllCards
      # POST /1/lists/[idList]/cards
      # POST /1/lists/[idList]/moveAllCards
      def create_list(board_id, name, options = {})
        post "lists", options.merge(name: name, 'idBoard' => board_id)
      end

    end
  end
end
