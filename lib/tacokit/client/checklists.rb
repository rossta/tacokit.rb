module Tacokit
  class Client
    module Checklists

      # GET /1/checklists/[idChecklist]
      def checklist(checklist_id, options = nil)
        get "checklists/#{checklist_id}", options
      end

      # GET /1/checklists/[idChecklist]/[field]
      def checklist_field(checklist_id, field)
        get "checklists/#{checklist_id}/#{field.to_s.camelize(:lower)}"
      end

      # GET /1/checklists/[idChecklist]/board
      # GET /1/checklists/[idChecklist]/board/[field]
      # GET /1/checklists/[idChecklist]/checklists
      # GET /1/checklists/[idChecklist]/checklists/[filter]
      # GET /1/checklists/[idChecklist]/checkItems
      # GET /1/checklists/[idChecklist]/checkItems/[idCheckItem]
      def checklist_resource(checklist_id, resource, options = nil)
        get "checklists/#{checklist_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/checklists/[idChecklist]
      # PUT /1/checklists/[idChecklist]/idCard
      # PUT /1/checklists/[idChecklist]/name
      # PUT /1/checklists/[idChecklist]/pos
      def update_checklist(checklist_id, options = {})
        put "checklists/#{checklist_id}", options
      end

      # POST /1/checklists
      # POST /1/checklists/[idChecklist]/checkItems
      def create_checklist(card_id, name, options = {})
        options.merge! \
          'idCard' => card_id,
          'name' => name
        post "checklists", options
      end

      # DELETE /1/checklists/[idChecklist]
      # DELETE /1/checklists/[idChecklist]/checkItems/[idCheckItem]
      def delete_checklist(checklist_id)
        delete "checklists/#{checklist_id}"
      end
    end
  end
end
