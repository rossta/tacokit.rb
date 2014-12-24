module Tacokit
  class Client
    module Lists

      # GET /1/lists/[idList]
      def list(list_id, options = nil)
        get "lists/#{list_id}", options
      end

      # GET /1/lists/[idList]/[field]
      def list_field(list_id, field, options = nil)
        get "lists/#{list_id}/#{to_path(field)}", options
      end

      # GET /1/lists/[idList]/[resource]
      # actions
      # board
      # board/[field]
      # lists
      # lists/[filter]
      def list_resource(list_id, resource, options = nil)
        get "lists/#{list_id}/#{to_path(resource)}", options
      end

      # PUT /1/lists/[idList]
      def update_list(list_id, options = {})
        put "lists/#{list_id}", options
      end

      # PUT /1/lists/[idList]/[field]
      # closed
      # idBoard
      # name
      # pos
      # subscribed

      # POST /1/lists
      def create_list(board_id, name, options = {})
        post "lists", options.merge(name: name, 'idBoard' => board_id)
      end

      # POST /1/lists/[idList]/[resource]
      # archiveAllCards
      # cards
      # moveAllCards

    end
  end
end
