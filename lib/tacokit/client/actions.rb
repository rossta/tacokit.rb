module Tacokit
  class Client
    module Actions
      # GET /1/actions/[idAction]
      def action(action_id, options = nil)
        get "actions/#{action_id}", options
      end

      # GET /1/actions/[idAction]/[field]
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
      # PUT /1/actions/[idAction]
      # PUT /1/actions/[idAction]/text
      # DELETE /1/actions/[idAction]
    end
  end
end
