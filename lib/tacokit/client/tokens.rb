module Tacokit
  class Client
    module Tokens

      # GET /1/tokens/[token]
      def token(token, options = nil)
        get "tokens/#{token}", options
      end

      # GET /1/tokens/[token]/[field]
      def token_field(token, field, options = nil)
        get "tokens/#{token}/#{to_path(field)}", options
      end

      # GET /1/tokens/[token]/[resource]
      # member
      # webhooks
      # member/[field]
      # webhooks/[idWebhook]
      def token_resource(token, resource, options = nil)
        get "tokens/#{token}/#{to_path(resource)}", options
      end

      # POST /1/tokens/[token]/webhooks

      # PUT /1/tokens/[token]/webhooks

      # DELETE /1/tokens/[token]
      def delete_token(token)
        delete "tokens/#{token}"
      end

      # DELETE /1/tokens/[token]/webhooks/[idWebhook]

    end
  end
end
