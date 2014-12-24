module Tacokit
  class Client
    module Actions

      # GET /1/actions/[idAction]
      def action(action_id, options = nil)
        get "actions/#{action_id}", options
      end

      # GET /1/actions/[idAction]/[field]
      def action_field(action_id, field)
        get "actions/#{action_id}/#{to_path(field)}"
      end

      # GET /1/actions/[idAction]/[resource]
      # board
      # board/[field]
      # card
      # card/[field]
      # entities
      # list
      # list/[field]
      # member
      # member/[field]
      # memberCreator
      # memberCreator/[field]
      # organization
      # organization/[field]
      def action_resource(action_id, resource, options = nil)
        get "actions/#{action_id}/#{to_path(resource)}", options
      end

      # PUT /1/actions/[idAction]
      def update_action(action_id, options = {})
        put "actions/#{action_id}", options
      end

      # PUT /1/actions/[idAction]/text

      # DELETE /1/actions/[idAction]
      def delete_action(action_id)
        delete "actions/#{action_id}"
      end
    end
  end
end
