module Tacokit
  class Client
    module Actions
      # GET /1/actions/[idAction]
      def action(action_id, options = nil)
        get "actions/#{action_id}", options
      end

      # GET /1/actions/[idAction]/[field]
      def action_field(action_id, field)
        get "actions/#{action_id}/#{field.to_s.camelize(:lower)}"
      end

      # GET /1/actions/[idAction]/board
      # GET /1/actions/[idAction]/board/[field]
      # GET /1/actions/[idAction]/card
      # GET /1/actions/[idAction]/card/[field]
      # GET /1/actions/[idAction]/entities
      # GET /1/actions/[idAction]/list
      # GET /1/actions/[idAction]/list/[field]
      # GET /1/actions/[idAction]/member
      # GET /1/actions/[idAction]/member/[field]
      # GET /1/actions/[idAction]/memberCreator
      # GET /1/actions/[idAction]/memberCreator/[field]
      # GET /1/actions/[idAction]/organization
      # GET /1/actions/[idAction]/organization/[field]
      def action_resource(action_id, resource, options = nil)
        get "actions/#{action_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/actions/[idAction]
      # PUT /1/actions/[idAction]/text
      # DELETE /1/actions/[idAction]
    end
  end
end
