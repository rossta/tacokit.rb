module Tacokit
  class Client
    module Searches
      # GET /1/search
      def search(query, options = {})
        get search_path, options.merge(query: query)
      end

      # GET /1/search/members
      def search_members(query, options = {})
        get search_path("members"), options.merge(query: query)
      end

      def search_path(*paths)
        path_join "search", *paths
      end
    end
  end
end
