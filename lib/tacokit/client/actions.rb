module Tacokit
  class Client
    module Actions

      # GET /1/actions/[idAction]
      def action(action_id, options = nil)
        get action_path(action_id), options
      end

      # GET /1/actions/[idAction]/[field]
      def action_field(action_id, field)
        get action_path(action_id, camp(field))
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
      def action_resource(action_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get action_path(action_id, *paths), options
      end

      # PUT /1/actions/[idAction]
      def update_action(action_id, options = {})
        put action_path(action_id), options
      end

      # PUT /1/actions/[idAction]/text
      def update_action_text(action_id, text)
        put action_path(action_id, 'text'), value: text
      end

      # DELETE /1/actions/[idAction]
      def delete_action(action_id)
        delete action_path(action_id)
      end

      def action_path(*paths)
        path_join("actions", *paths)
      end
    end
  end
end
