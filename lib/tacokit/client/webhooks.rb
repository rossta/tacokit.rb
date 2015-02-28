module Tacokit
  class Client
    module Webhooks
      # GET /1/webhooks/[idWebhook]
      def webhook(webhook_id)
        get webhook_path(webhook_id)
      end

      # GET /1/webhooks/[idWebhook]/[field]
      def webhook_field(webhook_id, field, options = nil)
        get webhook_path(webhook_id, camp(field)), options
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
        post webhook_path, options
      end

      # DELETE /1/webhooks/[idWebhook]
      def delete_webhook(webhook_id)
        delete webhook_path(webhook_id)
      end

      def webhook_path(*paths)
        path_join "webhooks", *paths
      end
    end
  end
end
