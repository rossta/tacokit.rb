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
      # POST /1/checklists
      # POST /1/checklists/[idChecklist]/checkItems
      # DELETE /1/checklists/[idChecklist]
      # DELETE /1/checklists/[idChecklist]/checkItems/[idCheckItem]
    end
  end
end
