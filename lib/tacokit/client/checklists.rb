module Tacokit
  class Client
    module Checklists
      # GET /1/checklists/[idChecklist]
      # GET /1/checklists/[idChecklist]/[field]
      # GET /1/checklists/[idChecklist]/board
      # GET /1/checklists/[idChecklist]/board/[field]
      # GET /1/checklists/[idChecklist]/cards
      # GET /1/checklists/[idChecklist]/cards/[filter]
      # GET /1/checklists/[idChecklist]/checkItems
      # GET /1/checklists/[idChecklist]/checkItems/[idCheckItem]
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
