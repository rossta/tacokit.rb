module Tacokit
  class Client
    # Methods for the Notifications API
    # @see https://developers.trello.com/advanced-reference/notification
    module Notifications
      # Retrieve a notification
      # @param notification_id [String] the notification identifier
      # @param options [Hash] options to fetch the notification with
      # @return [Tacokit::Resource] the notification resource
      # @example Retrieve a notification with its board
      #   Tacokit.notification("aNotificationId", board: true) #=> Tacokit::Resource<Notification>
      # @see https://developers.trello.com/advanced-reference/notification#get-1-notifications-idnotification
      def notification(notification_id, options = nil)
        get notification_path(notification_id), options
      end

      # Mark a notification as unread
      # @param notification_id [String] the notification identifier
      # @example Mark a notification as unread
      #   Tacokit.mark_notification_unread("aNotificationId") #=> Tacokit::Resource<Notification>
      # @see https://developers.trello.com/advanced-reference/notification#put-1-notifications-idnotification
      def mark_notification_unread(notification_id)
        update_notification notification_id, unread: true
      end

      # Mark a notification as read
      # @param notification_id [String] the notification identifier
      # @example Mark a notification as read
      #   Tacokit.mark_notification_read("aNotificationId") #=> Tacokit::Resource<Notification>
      # @see https://developers.trello.com/advanced-reference/notification#put-1-notifications-idnotification
      def mark_notification_read(notification_id)
        update_notification notification_id, unread: false
      end

      # Update read/unread status of notification
      # @param notification_id [String] the notification identifier
      # @param options [Hash] options to update the notification with
      # @example Mark a notification as unread
      #   Tacokit.update_notification("aNotificationId", unread: true) #=> Tacokit::Resource<Notification>
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
