module Tacokit
  class Client
    module Cards

      # GET /1/cards/[card id or shortlink]
      def card(card_id, options = nil)
        get "cards/#{card_id}", options
      end

      # GET /1/cards/[card id or shortlink]/[field]
      def card_field(card_id, field, options = nil)
        get "cards/#{card_id}/#{to_path(field)}", options
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
      def card_resource(card_id, resource, options = {})
        get "cards/#{card_id}/#{to_path(resource)}", options
      end

      # PUT /1/cards/[card id or shortlink]
      def update_card(card_id, options = {})
        put "cards/#{card_id}", options
      end

      # POST /1/cards
      def create_card(list_id, name = nil, options = {})
        post "cards", options.merge(name: name, 'idList' => list_id)
      end

      # DELETE /1/cards/[card id or shortlink]
      def delete_card(card_id)
        delete "cards/#{card_id}"
      end

      def create_card_resource(card_id, resource, options = {})
        post "cards/#{card_id}/#{resource}", options
      end

      # POST /1/cards/[card id or shortlink]/actions/comments
      # POST /1/cards/[card id or shortlink]/attachments
      def create_card_attachment(card_id, url, mime_type = nil, options = {})
        uri = Addressable::URI.parse(url)

        if uri.scheme =~ %r{https?}
          options.update url: uri.to_s, mime_type: mime_type
        else
          file = Faraday::UploadIO.new(uri.to_s, mime_type)
          options.update file: file, mime_type: file.content_type
        end

        create_card_resource card_id, 'attachments', options
      end

      # POST /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem
      # POST /1/cards/[card id or shortlink]/checklist/[idChecklist]/checkItem/[idCheckItem]/convertToCard
      # POST /1/cards/[card id or shortlink]/checklists
      # POST /1/cards/[card id or shortlink]/idMembers
      # POST /1/cards/[card id or shortlink]/labels
      # POST /1/cards/[card id or shortlink]/markAssociatedNotificationsRead
      # POST /1/cards/[card id or shortlink]/membersVoted
      # POST /1/cards/[card id or shortlink]/stickers

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
