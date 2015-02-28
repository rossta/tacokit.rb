module Tacokit
  class Client
    module Lists
      # GET /1/lists/[idList]
      def list(list_id, options = nil)
        get list_path(list_id), options
      end

      # GET /1/lists/[idList]/[field]
      def list_field(list_id, field, options = nil)
        get list_path(list_id, camp(field)), options
      end

      # GET /1/lists/[idList]/[resource]
      # actions
      # board
      # board/[field]
      # lists
      # lists/[filter]
      def list_resource(list_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get list_path(list_id, *paths), options
      end

      # PUT /1/lists/[idList]
      def update_list(list_id, options = {})
        put list_path(list_id), options
      end

      # PUT /1/lists/[idList]/[field]
      # closed
      # idBoard
      # name
      # pos
      # subscribed

      # POST /1/lists
      def create_list(board_id, name, options = {})
        post list_path, options.merge(name: name, board_id: board_id)
      end

      # POST /1/lists/[idList]/[resource]
      # archiveAllCards
      # cards
      # moveAllCards

      def list_path(*paths)
        path_join("lists", *paths)
      end
    end
  end
end
