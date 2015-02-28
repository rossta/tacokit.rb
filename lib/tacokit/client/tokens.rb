module Tacokit
  class Client
    module Tokens
      # GET /1/tokens/[token]
      def token(token, options = nil)
        get token_path(token), options
      end

      # GET /1/tokens/[token]/[field]
      def token_field(token, field, options = nil)
        get token_path(token, camp(field)), options
      end

      # GET /1/tokens/[token]/[resource]
      # member
      # webhooks
      # member/[field]
      # webhooks/[idWebhook]
      def token_resource(token, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get token_path(token, *paths), options
      end

      # POST /1/tokens/[token]/webhooks

      # PUT /1/tokens/[token]/webhooks

      # DELETE /1/tokens/[token]
      def delete_token(token)
        delete token_path(token)
      end

      # DELETE /1/tokens/[token]/webhooks/[idWebhook]

      def token_path(*paths)
        path_join "tokens", *paths
      end
    end
  end
end
