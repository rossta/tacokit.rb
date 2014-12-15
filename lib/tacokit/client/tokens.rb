module Tacokit
  class Client
    module Tokens
      # GET /1/tokens/[token]
      def token(token)
        get "token/#{token}"
      end

      # GET /1/tokens/[token]/[field]
      # GET /1/tokens/[token]/member
      # GET /1/tokens/[token]/member/[field]
      # GET /1/tokens/[token]/webhooks
      # GET /1/tokens/[token]/webhooks/[idWebhook]
      # PUT /1/tokens/[token]/webhooks
      # POST /1/tokens/[token]/webhooks
      # DELETE /1/tokens/[token]
      # DELETE /1/tokens/[token]/webhooks/[idWebhook]
    end
  end
end
