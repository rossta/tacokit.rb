module Tacokit
  class Client
    module Webhooks

      # GET /1/webhooks/[idWebhook]
      def webhook(webhook_id)
        get "webhooks/#{webhook_id}"
      end

      # GET /1/webhooks/[idWebhook]/[field]
      def webhook_field(webhook_id, field, options = nil)
        get "webhooks/#{webhook_id}/#{to_path(field)}", options
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
      def create_webhook(token, model_id, callback_url, options = {})
        options.merge! \
          'token' => token,
          'idModel' => model_id,
          'callbackURL' => callback_url
        post "webhooks", options
      end

      # DELETE /1/webhooks/[idWebhook]
      def delete_webhook(webhook_id)
        delete "webhooks/#{webhook_id}"
      end
    end
  end
end
