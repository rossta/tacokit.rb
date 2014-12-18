module Tacokit
  class Client
    module Webhooks

      # GET /1/webhooks/[idWebhook]
      def webhook(webhook_id)
        get "webhooks/#{webhook_id}"
      end

      # GET /1/webhooks/[idWebhook]/[field]
      def webhook_field(webhook_id, field, options = nil)
        get "webhooks/#{webhook_id}/#{field.to_s.camelize(:lower)}", options
      end

      # PUT /1/webhooks/[idWebhook]
      # PUT /1/webhooks/
      # PUT /1/webhooks/[idWebhook]/active
      # PUT /1/webhooks/[idWebhook]/callbackURL
      # PUT /1/webhooks/[idWebhook]/description
      # PUT /1/webhooks/[idWebhook]/idModel
      def update_webhook(webhook_id, options = {})
        put "webhooks/#{webhook_id}", options
      end

      # POST /1/webhooks
      # DELETE /1/webhooks/[idWebhook]
    end
  end
end