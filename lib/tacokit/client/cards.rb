module Tacokit
  class Client
    module Cards

      # GET cards/[card id or shortlink]
      def card(card_id, options = nil)
        get "cards/#{card_id}", options
      end

      # GET cards/[card id or shortlink]/[field]
      # badges
      # checkItemStates
      # closed
      # dateLastActivity
      # desc
      # descData
      # due
      # email
      # idAttachmentCover
      # idBoard
      # idChecklists
      # idLabels
      # idList
      # idMembers
      # idMembersVoted
      # idShort
      # labels
      # manualCoverAttachment
      # name
      # pos
      # shortLink
      # shortUrl
      # subscribed
      # url
      def card_field(card_id, field, options = nil)
        get "cards/#{card_id}/#{to_path(field)}", options
      end

      # GET cards/[card id or shortlink]/[resource]
      # actions
      # attachments
      # attachments/[idAttachment]
      # board
      # board/[field]
      # checkItemStates
      # checklists
      # list
      # list/[field]
      # members
      # membersVoted
      # stickers
      # stickers/[idSticker]
      def card_resource(card_id, resource, options = {})
        get "cards/#{card_id}/#{to_path(resource)}", options
      end

      # PUT cards/[card id or shortlink]
      def update_card(card_id, options = {})
        put "cards/#{card_id}", options
      end

      # PUT cards/[card id or shortlink]/[resource]
      # actions/[idAction]/comments
      # checklist/[idChecklist]/checkItem/[idCheckItem]/name
      # checklist/[idChecklist]/checkItem/[idCheckItem]/pos
      # checklist/[idChecklist]/checkItem/[idCheckItem]/state
      # checklist/[idChecklistCurrent]/checkItem/[idCheckItem]
      # closed
      # desc
      # due
      # idAttachmentCover
      # idBoard
      # idList
      # idMembers
      # labels
      # name
      # pos
      # stickers/[idSticker]
      # subscribed

      # POST cards
      def create_card(list_id, name = nil, options = {})
        post "cards", options.merge(name: name, 'idList' => list_id)
      end

      # POST cards/[card id or shortlink]/actions/comments
      def create_card_comment(card_id, text, options = {})
        options.update text: text
        create_card_resource card_id, "actions", "comments", options
      end

      # POST cards/[card id or shortlink]/attachments
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

      # POST cards/[card id or shortlink]/[resource]
      # checklist/[idChecklist]/checkItem
      # checklist/[idChecklist]/checkItem/[idCheckItem]/convertToCard
      # checklists
      # idMembers
      # labels
      # markAssociatedNotificationsRead
      # membersVoted
      # stickers
      def create_card_resource(card_id, *args)
        paths, options = extract_options(*args)
        post "cards/#{card_id}/#{to_path(*paths)}", options
      end

      # DELETE cards/[card id or shortlink]
      def delete_card(card_id)
        delete "cards/#{card_id}"
      end

      # DELETE cards/[card id or shortlink]/[resource]
      # actions/[idAction]/comments
      # attachments/[idAttachment]
      # checklist/[idChecklist]/checkItem/[idCheckItem]
      # checklists/[idChecklist]
      # idMembers/[idMember]
      # labels/[color]
      # membersVoted/[idMember]
      # stickers/[idSticker]
      def delete_card_resource(card_id, *resources)
        delete "cards/#{card_id}/#{to_path(*resources)}"
      end
    end
  end
end
