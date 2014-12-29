module Tacokit
  class Client
    module Checklists

      # GET /1/checklists/[idChecklist]
      def checklist(checklist_id, options = nil)
        get checklist_path(checklist_id), options
      end

      # GET /1/checklists/[idChecklist]/[field]
      def checklist_field(checklist_id, field)
        get checklist_path(checklist_id, camp(field))
      end

      # GET /1/checklists/[idChecklist]/[resource]
      # board
      # board/[field]
      # checklists
      # checklists/[filter]
      # checkItems
      # checkItems/[idCheckItem]
      def checklist_resource(checklist_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        get checklist_path(checklist_id, *paths), options
      end

      # PUT /1/checklists/[idChecklist]
      def update_checklist(checklist_id, options = {})
        put checklist_path(checklist_id), options
      end

      # PUT /1/checklists/[idChecklist]/[field]
      # idCard
      # name
      # pos

      # POST /1/checklists
      def create_checklist(card_id, name, options = {})
        options.update \
          card_id: card_id,
          name: name
        post checklist_path, options
      end

      # POST /1/checklists/[idChecklist]/checkItems

      # DELETE /1/checklists/[idChecklist]
      def delete_checklist(checklist_id)
        delete checklist_path(checklist_id)
      end

      # DELETE /1/checklists/[idChecklist]/checkItems/[idCheckItem]

      def checklist_path(*paths)
        path_join("checklists", *paths)
      end
    end
  end
end
