module Tacokit
  class Client
    module Tokens

      # GET /1/tokens/[token]
      def token(token, options = nil)
        get "tokens/#{token}", options
      end

      # GET /1/tokens/[token]/[field]
      def token_field(token, field, options = nil)
        get "tokens/#{token}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/tokens/[token]/member
      # GET /1/tokens/[token]/webhooks
      # GET /1/tokens/[token]/member/[field]
      # GET /1/tokens/[token]/webhooks/[idWebhook]
      def token_resource(token, resource, options = nil)
        get "tokens/#{token}/#{resource.to_s.camelize(:lower)}", options
      end

      # POST /1/tokens/[token]/webhooks
      # PUT /1/tokens/[token]/webhooks

      # DELETE /1/tokens/[token]
      # DELETE /1/tokens/[token]/webhooks/[idWebhook]
      def delete_token(token)
        delete "tokens/#{token}"
      end
    end
  end
end
