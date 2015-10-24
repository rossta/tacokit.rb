module Tacokit
  class Client
    module Webhooks
      # Update a webhook
      #
      # @see https://developers.trello.com/advanced-reference/webhook#put-1-webhooks
      def update_webhook(webhook_id, options = {})
        put webhook_path(webhook_id), options
      end

      # Create a webhook
      #
      # @see https://developers.trello.com/advanced-reference/webhook#post-1-webhooks
      def create_webhook(token, model_id, callback_url, options = {})
        options.update \
          model_id: model_id,
          callback_url: callback_url
        post "webhooks", options
      end

      # Delete a webhook
      #
      # @see https://developers.trello.com/advanced-reference/webhook#delete-1-webhooks-idwebhook
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
