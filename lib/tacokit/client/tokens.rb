module Tacokit
  class Client
    module Tokens
      # Get an authorization token
      #
      # @see https://developers.trello.com/advanced-reference/token#get-1-tokens-token
      def token(token, options = nil)
        get token_path(token), options
      end

      # Delete an authorization token
      #
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
