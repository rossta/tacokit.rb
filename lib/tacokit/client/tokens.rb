module Tacokit
  class Client
    module Tokens

      # GET /1/tokens/[token]
      def token(token, options = nil)
        get "tokens/#{token}", options
      end

      # GET /1/tokens/[token]/[field]
      def token_field(token_id, field, options = nil)
        get "tokens/#{token_id}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/tokens/[token]/member
      # GET /1/tokens/[token]/webhooks
      # GET /1/tokens/[token]/member/[field]
      # GET /1/tokens/[token]/webhooks/[idWebhook]
      def token_resource(token_id, resource, options = nil)
        get "tokens/#{token_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # POST /1/tokens/[token]/webhooks
      # PUT /1/tokens/[token]/webhooks

      # DELETE /1/tokens/[token]
      # DELETE /1/tokens/[token]/webhooks/[idWebhook]
    end
  end
end
