module Tacokit
  class Client
    module Notifications

      # GET /1/notifications/[idNotification]
      def notification(notification_id, options = nil)
        get notification_path(notification_id), options
      end

      # GET /1/notifications/[idNotification]/[field]
      def notification_field(notification_id, field)
        get notification_path(notification_id, camp(field))
      end

      # GET /1/notifications/[idNotification]/[resource]
      # board
      # board/[field]
      # notification
      # notification/[field]
      # entities
      # list
      # list/[field]
      # member
      # member/[field]
      # memberCreator
      # memberCreator/[field]
      # organization
      # organization/[field]
      def notification_resource(notification_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get notification_path(notification_id, *paths), options
      end

      # PUT /1/notifications/[idNotification]
      def update_notification(notification_id, options = {})
        put notification_path(notification_id), options
      end

      # PUT /1/notifications/[idNotification]/unread

      # POST /1/notifications/all/read

      def notification_path(*paths)
        path_join "notifications", *paths
      end
    end
  end
end
