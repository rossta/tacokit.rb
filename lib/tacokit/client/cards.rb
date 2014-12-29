module Tacokit
  class Client
    module Cards

      # GET cards/[card id or shortlink]
      def card(card_id, options = nil)
        get card_path(card_id), options
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
        get card_path(card_id, camp(field)), options
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
        get card_path(card_id, camp(resource)), options
      end

      # PUT cards/[card id or shortlink]
      def update_card(card_id, options = {})
        put card_path(card_id), options
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
        post card_path, options.merge(name: name, list_id: list_id)
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
      def create_card_resource(card_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        post card_path(card_id, *paths), options
      end

      # DELETE cards/[card id or shortlink]
      def delete_card(card_id)
        delete card_path(card_id)
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
      def delete_card_resource(card_id, resource, *paths)
        delete card_path(card_id, camp(resource), *paths)
      end

      def card_path(*paths)
        path_join "cards", *paths
      end
    end
  end
end
