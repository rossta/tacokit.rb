module Tacokit
  class Client
    # Methods for the Search API
    # @see https://developers.trello.com/advanced-reference/search
    module Searches
      # Search across resources with a query
      # @param query [String] the text of the search query
      # @param options [Hash] options to retrieve the search results with
      # @return the search results
      # @example Search for any resource with query "technology"
      #   Tacokit.search("technology") #=> Tacokit::Collection
      # @example Search for cards with query "music"
      #   Tacokit.search("music", model_types: "cards") #=> Tacokit::Collection
      # @see https://developers.trello.com/advanced-reference/search#get-1-search
      def search(query, options = {})
        get search_path, options.merge(query: query)
      end

      # Search members with a query
      # @param query [String] the text of the search query
      # @param options [Hash] options to retrieve the search results with
      # @return the search results
      # @example Search for members with query "Marsha"
      #   Tacokit.search("Marsha") #=> Tacokit::Collection<Member>
      def search_members(query, options = {})
        get search_path("members"), options.merge(query: query)
      end

      private

      def search_path(*paths)
        path_join "search", *paths
      end
    end
  end
end
