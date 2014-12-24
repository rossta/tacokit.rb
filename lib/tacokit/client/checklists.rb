module Tacokit
  class Client
    module Checklists

      # GET /1/checklists/[idChecklist]
      def checklist(checklist_id, options = nil)
        get "checklists/#{checklist_id}", options
      end

      # GET /1/checklists/[idChecklist]/[field]
      def checklist_field(checklist_id, field)
        get "checklists/#{checklist_id}/#{to_path(field)}"
      end

      # GET /1/checklists/[idChecklist]/[resource]
      # board
      # board/[field]
      # checklists
      # checklists/[filter]
      # checkItems
      # checkItems/[idCheckItem]
      def checklist_resource(checklist_id, resource, options = nil)
        get "checklists/#{checklist_id}/#{to_path(resource)}", options
      end

      # PUT /1/checklists/[idChecklist]
      def update_checklist(checklist_id, options = {})
        put "checklists/#{checklist_id}", options
      end

      # PUT /1/checklists/[idChecklist]/[field]
      # idCard
      # name
      # pos

      # POST /1/checklists
      def create_checklist(card_id, name, options = {})
        options.merge! \
          'idCard' => card_id,
          'name' => name
        post "checklists", options
      end

      # POST /1/checklists/[idChecklist]/checkItems

      # DELETE /1/checklists/[idChecklist]
      def delete_checklist(checklist_id)
        delete "checklists/#{checklist_id}"
      end

      # DELETE /1/checklists/[idChecklist]/checkItems/[idCheckItem]

    end
  end
end
