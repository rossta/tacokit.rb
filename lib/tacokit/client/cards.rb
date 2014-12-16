module Tacokit
  class Client
    module Cards
      # GET /1/cards/[card id or shortlink]
      def card(card_id, options = nil)
        get "cards/#{card_id}", options
      end

      # GET /1/cards/[card id or shortlink]/[field]
      def card_field(card_id, field, options = nil)
        get "cards/#{card_id}/#{field.to_s.camelize(:lower)}", options
      end

      # GET /1/cards/[card id or shortlink]/actions
      # GET /1/cards/[card id or shortlink]/attachments
      # GET /1/cards/[card id or shortlink]/attachments/[idAttachment]
      # GET /1/cards/[card id or shortlink]/board
      # GET /1/cards/[card id or shortlink]/board/[field]
      # GET /1/cards/[card id or shortlink]/checkItemStates
      # GET /1/cards/[card id or shortlink]/checklists
      # GET /1/cards/[card id or shortlink]/list
      # GET /1/cards/[card id or shortlink]/list/[field]
      # GET /1/cards/[card id or shortlink]/members
      # GET /1/cards/[card id or shortlink]/membersVoted
      # GET /1/cards/[card id or shortlink]/stickers
      # GET /1/cards/[card id or shortlink]/stickers/[idSticker]
      def card_resource(card_id, resource, options = nil)
        get "cards/#{card_id}/#{resource.to_s.camelize(:lower)}", options
      end

      # PUT /1/cards/[card id or shortlink]
      # PUT /1/cards/[card id or shortlink]/actions/[idAction]/comments
      # PUT /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]/name
      # PUT /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]/pos
      # PUT /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]/state
      # PUT /1/cards/[card id or shortlink]/checklist/[idChecklistCurrent]/checkItem/[idCheckItem]
      # PUT /1/cards/[card id or shortlink]/closed
      # PUT /1/cards/[card id or shortlink]/desc
      # PUT /1/cards/[card id or shortlink]/due
      # PUT /1/cards/[card id or shortlink]/idAttachmentCover
      # PUT /1/cards/[card id or shortlink]/idBoard
      # PUT /1/cards/[card id or shortlink]/idList
      # PUT /1/cards/[card id or shortlink]/idMembers
      # PUT /1/cards/[card id or shortlink]/labels
      # PUT /1/cards/[card id or shortlink]/name
      # PUT /1/cards/[card id or shortlink]/pos
      # PUT /1/cards/[card id or shortlink]/stickers/[idSticker]
      # PUT /1/cards/[card id or shortlink]/subscribed
      # POST /1/cards
      # POST /1/cards/[card id or shortlink]/actions/comments
      # POST /1/cards/[card id or shortlink]/attachments
      # POST /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem
      # POST /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]/convertToCard
      # POST /1/cards/[card id or shortlink]/checklists
      # POST /1/cards/[card id or shortlink]/idMembers
      # POST /1/cards/[card id or shortlink]/labels
      # POST /1/cards/[card id or shortlink]/markAssociatedNotificationsRead
      # POST /1/cards/[card id or shortlink]/membersVoted
      # POST /1/cards/[card id or shortlink]/stickers
      # DELETE /1/cards/[card id or shortlink]
      # DELETE /1/cards/[card id or shortlink]/actions/[idAction]/comments
      # DELETE /1/cards/[card id or shortlink]/attachments/[idAttachment]
      # DELETE /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]
      # DELETE /1/cards/[card id or shortlink]/checklists/[idChecklist]
      # DELETE /1/cards/[card id or shortlink]/idMembers/[idMember]
      # DELETE /1/cards/[card id or shortlink]/labels/[color]
      # DELETE /1/cards/[card id or shortlink]/membersVoted/[idMember]
      # DELETE /1/cards/[card id or shortlink]/stickers/[idSticker]
    end
  end
end
