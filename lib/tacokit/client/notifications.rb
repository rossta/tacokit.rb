module Tacokit
  class Client
    module Notifications
      # Retrieve a notification
      #
      # @see https://developers.trello.com/advanced-reference/notification#get-1-notifications-idnotification
      def notification(notification_id, options = nil)
        get notification_path(notification_id), options
      end

      # Update read/unread status of notification
      #
      # @see https://developers.trello.com/advanced-reference/notification#put-1-notifications-idnotification
      def update_notification(notification_id, options = {})
        put notification_path(notification_id), options
      end

      private

      def notification_resource(notification_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get notification_path(notification_id, *paths), options
      end

      def notification_path(notification_id, *paths)
        resource_path "notifications", notification_id, *paths
      end
    end
  end
end
