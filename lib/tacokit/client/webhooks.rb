module Tacokit
  class Client
    module Webhooks
      # GET /1/webhooks/[idWebhook]
      def webhook(webhook_id)
        get "webhooks/#{webhook_id}"
      end

      # GET /1/webhooks/[idWebhook]/[field]
      # PUT /1/webhooks/[idWebhook]
      # PUT /1/webhooks/
      # PUT /1/webhooks/[idWebhook]/active
      # PUT /1/webhooks/[idWebhook]/callbackURL
      # PUT /1/webhooks/[idWebhook]/description
      # PUT /1/webhooks/[idWebhook]/idModel
      # POST /1/webhooks
      # DELETE /1/webhooks/[idWebhook]
    end
  end
end
