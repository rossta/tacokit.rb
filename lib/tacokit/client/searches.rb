module Tacokit
  class Client
    module Searches

      # GET /1/search
      def search(query, options = {})
        get "search", options.merge(query: query)

      end
      # GET /1/search/members
    end
  end
end
