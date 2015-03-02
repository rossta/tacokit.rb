module Tacokit
  class Client
    module Notifications
      # Retrieve a notification
      #
      # @see https://trello.com/docs/api/notification/index.html#get-1-notifications-idnotification
      def notification(notification_id, options = nil)
        get notification_path(notification_id), options
      end

      # Update read/unread status of notification
      #
      # @see https://trello.com/docs/api/notification/index.html#put-1-notifications-idnotification
      def update_notification(notification_id, options = {})
        put notification_path(notification_id), options
      end

      # PUT /1/notifications/[idNotification]/unread

      # POST /1/notifications/all/read

      private

      def notification_resource(notification_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get notification_path(notification_id, *paths), options
      end

      def notification_path(*paths)
        path_join "notifications", *paths
      end
    end
  end
end
