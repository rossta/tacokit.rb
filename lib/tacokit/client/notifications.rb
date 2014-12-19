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

      # GET /1/notifications/[idNotification]/board
      # GET /1/notifications/[idNotification]/board/[field]
      # GET /1/notifications/[idNotification]/notification
      # GET /1/notifications/[idNotification]/notification/[field]
      # GET /1/notifications/[idNotification]/entities
      # GET /1/notifications/[idNotification]/list
      # GET /1/notifications/[idNotification]/list/[field]
      # GET /1/notifications/[idNotification]/member
      # GET /1/notifications/[idNotification]/member/[field]
      # GET /1/notifications/[idNotification]/memberCreator
      # GET /1/notifications/[idNotification]/memberCreator/[field]
      # GET /1/notifications/[idNotification]/organization
      # GET /1/notifications/[idNotification]/organization/[field]
      def notification_resource(notification_id, resource, options = nil)
        get "notifications/#{notification_id}/#{to_path(resource)}", options
      end

      # PUT /1/notifications/[idNotification]
      # PUT /1/notifications/[idNotification]/unread
      def update_notification(notification_id, options = {})
        put "notifications/#{notification_id}", options
      end

      # POST /1/notifications/all/read
    end
  end
end
