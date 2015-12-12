module Tacokit
  class Client
    # Methods for the Webhooks API
    # @see https://developers.trello.com/advanced-reference/webhook
    module Webhooks
      # Update a webhook
      # @param webhook_id [String] the webhook identifier
      # @param options [Hash] options to update the webhook with
      # @return [Tacokit::Resource<Webhook>] the webhook resource
      # @example Update webhook description
      #   Tacokit.update_webhook(webhook.id, desc: "Here's the real webhook description") #=> Tacokit::Resource<Webhook>
      # @see https://developers.trello.com/advanced-reference/webhook#put-1-webhooks
      def update_webhook(webhook_id, options = {})
        put webhook_path(webhook_id), options
      end

      # Create a webhook
      # @param model_id [String] the id of the model that should be webhooked
      # @param callback_url [String] a url reachable with a HEAD request
      # @param options [String] options to create the webhook with
      # @return [Tacokit::Resource<Webhook>] the webhook resource
      # @example Create a webhook for a board
      #   board = Tacokit.boards.first
      #   Tacokit.create_webhook(board.id, "https://example.com/board/callback",
      #     desc: "My first Trello webhook!") #=> Tacokit::Resource<Webhook>
      # @see https://developers.trello.com/advanced-reference/webhook#post-1-webhooks
      def create_webhook(model_id, callback_url, options = {})
        options.update \
          model_id: model_id,
          callback_url: callback_url
        post "webhooks", options
      end

      # Delete a webhook
      # @param webhook_id [String] the webhook identifier
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
