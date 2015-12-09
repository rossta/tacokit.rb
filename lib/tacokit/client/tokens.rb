module Tacokit
  class Client
    # Methods for the Tokens API
    # @see https://developers.trello.com/advanced-reference/token
    module Tokens
      # Get an authorization token
      # @param token [String] the token identifier
      # @param options [Hash] options to fetch the token with
      # @return [Tacokit::Resource] the token resource
      # @see https://developers.trello.com/advanced-reference/token#get-1-tokens-token
      def token(token, options = nil)
        get token_path(token), options
      end

      # Delete an authorization token
      # @param token [String] the token identifier
      # @see https://developers.trello.com/advanced-reference/token#delete-1-tokens-token
      def delete_token(token)
        delete token_path(token)
      end

      # @private
      def token_resource(token, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get token_path(token, *paths), options
      end

      private

      def token_path(*paths)
        path_join "tokens", *paths
      end
    end
  end
end
