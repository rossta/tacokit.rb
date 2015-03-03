module Tacokit
  class Client
    module Webhooks
      # GET /1/webhooks/[idWebhook]
      def webhook(webhook_id)
        get webhook_path(webhook_id)
      end

      # PUT /1/webhooks/[idWebhook]
      def update_webhook(webhook_id, options = {})
        put webhook_path(webhook_id), options
      end

      # PUT /1/webhooks/[idWebhook]/[field]
      # active
      # callbackURL
      # description
      # idModel

      # POST /1/webhooks
      def create_webhook(token, model_id, callback_url, options = {})
        options.update \
          model_id: model_id,
          callback_url: callback_url
        post "webhooks", options
      end

      # DELETE /1/webhooks/[idWebhook]
      def delete_webhook(webhook_id)
        delete webhook_path(webhook_id)
      end

      private

      def webhook_path(webhook_id, *paths)
        resource_path "webhooks", webhook_id, *paths
      end
    end
  end
end
