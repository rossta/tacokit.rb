module Tacokit
  class Client
    module Notifications

      # GET /1/notifications/[idNotification]
      def notification(notification_id, options = nil)
        get "notifications/#{notification_id}", options
      end

      # GET /1/notifications/[idNotification]/[field]
      def notification_field(notification_id, field)
        get "notifications/#{notification_id}/#{to_path(field)}"
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
      def notification_resource(notification_id, resource, options = nil)
        get "notifications/#{notification_id}/#{to_path(resource)}", options
      end

      # PUT /1/notifications/[idNotification]
      def update_notification(notification_id, options = {})
        put "notifications/#{notification_id}", options
      end

      # PUT /1/notifications/[idNotification]/unread

      # POST /1/notifications/all/read
    end
  end
end
