require "uri"

module Tacokit
  class Client
    # Methods for the Cards API
    # @see https://developers.trello.com/advanced-reference/card
    module Cards
      # Retrieve a card by id or shortlink
      # @param card_id [String] the card identifier or shortlink
      # @return [Tacokit::Resource<Card>] the card resource
      # @example Retrieve a card by its id
      #   Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      # @example Retrieve a card by its short link with its members
      #   Tacokit.card("aCardShortLink", members: true) #=> Tacokit::Resource<Card>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink
      def card(card_id, options = nil)
        get card_path(card_id), options
      end

      # Retrieve card actions
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the actions with
      # @return [Tacokit::Collection<Action>] the action resources
      # @example Retrieve a card's comments
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.card_actions(card, filter: "comment_card") #=> Tacokit::Collection<Action>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-actions
      def card_actions(card_id, options = {})
        paginated_card_resource(card_id, "actions", options)
      end

      # Retrieve card attachments
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the attachments with
      # @return [Tacokit::Collection<Attachment>] the attachment resources
      # @example Retrieve attachments for a card
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.attachments(card) #=> Tacokit::Collection<Attachment>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-attachments
      def attachments(card_id, options = {})
        card_resource(card_id, "attachments", options)
      end
      alias_method :card_attachments, :attachments

      # Retrieve a card attachment
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param attachment_id [String] the attachment id
      # @param options [Hash] the options to fetch the attachments with
      # @return [Tacokit::Resource<Attachment>] the attachment resource
      # @example Retrieve a single card attachment
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.attachment(card, "anAttachmentId") #=> Tacokit::Resource<Attachment>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-attachments-idattachment
      def attachment(card_id, attachment_id, options = {})
        card_resource(card_id, "attachments/#{resource_id(attachment_id)}", options)
      end

      # Retrieve a card board
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the board with
      # @return [Tacokit::Resource<Board>] the board resource
      # @example Retrieve a card board
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.card_board(card) #=> Tacokit::Resource<Board>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-board
      def card_board(card_id, options = {})
        card_resource(card_id, "board", options)
      end

      # Retrieve card checklist item states
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the states with
      # @return [Tacokit::Collection] the check item state resources
      # @example Retrieve states of checked items
      #   Tacokit.check_item_states("aCardId") #=> Tacokit::Collection
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-board
      def check_item_states(card_id, options = {})
        card_resource(card_id, "check_item_states", options)
      end

      # Retrieve card checklists
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the checklists with
      # @return [Tacokit::Collection<Checklist>] the checklist resources
      # @example Retrieve checklists
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.checklists(card) #=> Tacokit::Collection<Checklist>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-board
      def checklists(card_id, options = {})
        card_resource(card_id, "checklists", options)
      end

      # Retrive a card list
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the list with
      # @return [Tacokit::Resource<List>] the list resource
      # @example Retrieve a card list
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.card_list(card) #=> Tacokit::Resource<List>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-list
      def card_list(card_id, options = {})
        card_resource(card_id, "list", options)
      end

      # Retrieve card members
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the members with
      # @return [Tacokit::Collection] the member resources
      # @example Retrieve a card's members
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.card_members(card) #=> Tacokit::Collection<Member>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-members
      def card_members(card_id, options = {})
        card_resource(card_id, "members", options)
      end

      # Retrieve members who voted on a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the members with
      # @return [Tacokit::Collection] the member resources
      # @example Retrieve members who voted for card
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.card_members_voted(card) #=> Tacokit::Collection<Member>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-membersvoted
      def card_members_voted(card_id, options = {})
        card_resource(card_id, "members_voted", options)
      end

      # Retrieve card stickers
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options to fetch the stickers with
      # @return [Tacokit::Collection] the sticker resources
      # @example Retrieve stickers on card
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.stickers(card) #=> Tacokit::Collection<Stickers>
      # @see https://developers.trello.com/advanced-reference/card#get-1-cards-card-id-or-shortlink-stickers
      def stickers(card_id, options = {})
        card_resource(card_id, "stickers", options)
      end

      # Update card attributes
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the attributes to update on the card
      # @example Update name of card
      #   card = Tacokit.card("aCardId") #=> Tacokit::Resource<Card>
      #   Tacokit.update_card(card, name: "New card") #=> Tacokit::Resource<Card>
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink
      def update_card(card_id, options = {})
        put card_path(card_id), options
      end

      # Update comment text
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param comment_id [String] the comment identifier
      # @param text [String] the updated comment text
      # @param options [Hash] the attributes to update on the comment
      # @example Change text of existing comment
      #   card = Tacokit.card("aCardId", action: "commentCard")
      #   comment = card.actions.first
      #   Tacokit.update_comment(card, comment, "New comment text")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-actions-idaction-comments
      def update_comment(card_id, comment_id, text, options = {})
        update_card_resource(card_id, "actions", resource_id(comment_id), "comments", options.merge(text: text))
      end
      alias_method :edit_comment, :update_comment

      # Update checklist item text, position or state
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param checklist_id [String] the checklist identifier
      # @param check_item_id [String] the check item identifier
      # @param options [Hash] the attributes to update on the check item
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-checklist-idchecklistcurrent-checkitem-idcheckitem
      def update_check_item(card_id, checklist_id, check_item_id, options = {})
        update_card_resource card_id,
          "checklist",
          resource_id(checklist_id),
          "checkItem",
          resource_id(check_item_id),
          options
      end

      # Archive a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @example Archive a card
      #   Tacokit.archive_card("aCardId")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-closed
      def archive_card(card_id)
        update_card(card_id, closed: true)
      end

      # Restore an archived card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @example Restore a card
      #   Tacokit.restore_card("aCardId")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-closed
      def restore_card(card_id)
        update_card(card_id, closed: false)
      end

      # Move card to another position, board and/or list
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param options [Hash] the options for moving the card
      # @option options [String] :board_id another board location
      # @option options [String] :list_id another list location
      # @option options [String] :pos new position in current list
      # @example Move card to the top of a new list
      #   card = Tacokit.card("aCardId")
      #   Tacokit.move_card(card, list_id: "aListId", pos: "top")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-idboard
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-idlist
      def move_card(card_id, options)
        unless options.is_a?(Hash) && ([:board_id, :list_id, :pos].any? { |key| options.key? key })
          raise ArgumentError, "Required option: :pos, :board_id and/or :list_id"
        end
        update_card(card_id, options)
      end

      # Update card name
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param name [String] a name for the card
      # @example Change card name
      #   Tacokit.update_card_name("aCardId", "New card name")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-name
      def update_card_name(card_id, name)
        put card_path(card_id, "name"), value: name
      end

      # Subscribe to card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @example Subscribe to card
      #   Tacokit.subscribe_to_card("aCardId")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-subscribed
      def subscribe_to_card(card_id)
        put card_path(card_id, "subscribed"), value: true
      end

      # Unubscribe from card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @example Unubscribe from card
      #   Tacokit.unsubscribe_from_card("aCardId")
      # @see https://developers.trello.com/advanced-reference/card#put-1-cards-card-id-or-shortlink-subscribed
      def unsubscribe_from_card(card_id)
        put card_path(card_id, "subscribed"), value: false
      end

      # Update any card resource
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param resource [String] a resource name, like board, list, attachment
      # @param paths [Hash, String] nested paths and/or options for updating the card's nested resource
      def update_card_resource(card_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        put card_path(card_id, *paths), options
      end

      # Create a new card
      # @param list_id [String, Tacokit::Resource<List>] the list identifier or list
      # @param name [String] a name for the card
      # @param options [Hash] options to create the card with
      # @example Create a new card at bottom of a given list
      #   Tacokit.create_card("aListId", "Card name", pos: "bottom")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards
      def create_card(list_id, name = nil, options = {})
        post "cards", options.merge(name: name, list_id: resource_id(list_id))
      end

      # Add a comment to a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param text [String] comment text
      # @param options [Hash] options to create the comment with
      # @example Add comment to a card
      #   Tacokit.add_comment("aCardId", "@bob What do you mean?")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-actions-comments
      def add_comment(card_id, text, options = {})
        options.update text: text
        create_card_resource card_id, "actions", "comments", options
      end
      alias_method :create_card_comment, :add_comment

      # Attach a file to a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param url [String] a local file path of http url to a file
      # @param mime_type [String] a mime type for http url
      # @param options [Hash] additional options to attach the file with
      # @example Attach a file from the file system
      #   Tacokit.attach_file("aCardId", "/path/to/local/file.png")
      # @example Attach a file the "Internet" with mime type
      #   Tacokit.attach_file("aCardId", "https://imgur.com/giphy.gif", "image/gif")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-attachments
      def attach_file(card_id, url, mime_type = nil, options = {})
        options = mime_type if mime_type.is_a?(Hash)

        uri = URI.parse(url)

        if uri.scheme =~ %r{https?}
          options.update url: uri.to_s, mime_type: mime_type
        else
          file = Faraday::UploadIO.new(uri.to_s, mime_type)
          options.update file: file, mime_type: file.content_type
        end

        create_card_resource card_id, "attachments", options
      end
      alias_method :create_card_attachment, :attach_file

      # Convert a checklist item to a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param checklist_id [String] the checklist identifier
      # @param check_item_id [String] the check item identifier to convert to a card
      # @example Convert a checklist item to a card
      #   card = Tacokit.card("aCardId", checklists: :all)
      #   checklist = card.checklists.first
      #   check_item = checklist.check_items.first
      #   Tacokit.convert_to_card(card, checklist, check_item)
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-checklist-idchecklist-checkitem-idcheckitem-converttocard
      def convert_to_card(card_id, checklist_id, check_item_id)
        create_card_resource card_id, "checklist", resource_id(checklist_id),
          "checkItem", resource_id(check_item_id), "convertToCard"
      end

      # Start a new checklist on card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param name [String] the new checklist name
      # @example Add checklist to card
      #   card = Tacokit.card("aCardId")
      #   checklist = Tacokit.add_checklist(card, "Tasks")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-checklists
      def add_checklist(card_id, name)
        create_card_resource(card_id, "checklists", name: name)
      end
      alias_method :start_checklist, :add_checklist

      # Copy another checklist to card
      # @param card_id [String, Tacokit::Resource<Card>] the destination card identifier, shortlink, or card
      # @param checklist_id [String] the checklist identifier
      #   card_1 = Tacokit.card("aCardId")
      #   checklist = card.add_checklist(card_1, "Tasks")
      #   card_2 = Tacokit.card("bCardId")
      #   Tacokit.copy_checklist(card_2, checklist)
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-checklists
      def copy_checklist(card_id, checklist_id)
        create_card_resource(card_id, "checklists", checklist_source_id: resource_id(checklist_id))
      end

      # Add a member to a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param member_id [String] the member identifier
      # @example Add a member to a card
      #   card = Tacokit.card("aCardId")
      #   member = Tacokit.member("nickname")
      #   Tacokit.add_member_to_card(card, member)
      # @example Add a member by id to a card
      #   Tacokit.add_member_to_card("aCardId", "aMemberId")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-idmembers
      def add_member_to_card(card_id, member_id)
        create_card_resource(card_id, "idMembers", value: resource_id(member_id))
      end

      # Add label to card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param color [String] a color name or hex value
      # @param options [Hash] options to add the label with
      # @example Add label to card
      #   Tacokit.add_label("aCardId", "red", name: "Overdue")
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-labels
      def add_label(card_id, color, options = {})
        create_card_resource(card_id, "labels", options.merge(color: color))
      end

      # Cast vote for card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param member_id [String] the voter member identifier
      # @example Vote on card for given member
      #   member = Tacokit.member("rossta")
      #   Tacokit.vote("aCardId", member)
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-membersvoted
      def vote(card_id, member_id)
        create_card_resource(card_id, "membersVoted", value: resource_id(member_id))
      end
      alias_method :create_vote, :vote

      # Add sticker to card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param image_name [String] the sticker name
      # @param options [Hash] options to add the sticker with, such as position arguments
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-stickers
      def add_sticker(card_id, image_name, options = {})
        defaults = { top: 0, left: 0, z_index: 1 }
        create_card_resource(card_id, "stickers", defaults.merge(options.merge(image: image_name)))
      end
      alias_method :create_sticker, :add_sticker

      # Create a card resource
      def create_card_resource(card_id, resource, *paths)
        paths, options = extract_options(camp(resource), *paths)
        post card_path(card_id, *paths), options
      end

      # Delete a chard
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink
      def delete_card(card_id)
        delete card_path(card_id)
      end

      # Remove a comment
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param comment_id [String] the comment identifier
      # @see https://developers.trello.com/advanced-reference/card#post-1-cards-card-id-or-shortlink-labels
      def remove_comment(card_id, comment_id)
        delete_card_resource card_id, "actions", comment_id, "comments"
      end
      alias_method :delete_comment, :remove_comment

      # Remove an attachment
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param attachment_id [String] the attachment identifier
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-attachments-idattachment
      def remove_attachment(card_id, attachment_id)
        delete_card_resource card_id, "attachments", attachment_id
      end
      alias_method :delete_attachement, :remove_attachment

      # Remove checklist
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param checklist_id [String] the checklist identifier
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-checklists-idchecklist
      def remove_checklist(card_id, checklist_id)
        delete_card_resource card_id, "checklists", checklist_id
      end
      alias_method :delete_checklist, :remove_checklist

      # Remove a member from a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param member_id [String] the member identifier
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-idmembers-idmember
      def remove_card_member(card_id, member_id)
        delete_card_resource card_id, "idMembers", member_id
      end
      alias_method :delete_card_member, :remove_card_member

      # Remove label from card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param color [String] color of label to remove
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-labels-color
      def remove_label(card_id, color)
        delete_card_resource card_id, "labels", color
      end
      alias_method :delete_label, :remove_label

      # Remove a vote from a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param member_id [String] the member identifier
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-membersvoted-idmember
      def remove_vote(card_id, member_id)
        delete_card_resource card_id, "membersVoted", member_id
      end
      alias_method :delete_vote, :remove_vote

      # Remove a sticker from a card
      # @param card_id [String, Tacokit::Resource<Card>] the card identifier, shortlink, or card
      # @param sticker_id [String] the sticker identifier
      # @see https://developers.trello.com/advanced-reference/card#delete-1-cards-card-id-or-shortlink-membersvoted-idmember
      def remove_sticker(card_id, sticker_id)
        delete_card_resource card_id, "stickers", sticker_id
      end
      alias_method :delete_sticker, :remove_sticker

      private

      def card_resource(card_id, resource, options = {})
        get card_path(card_id, camp(resource)), options
      end

      def paginated_card_resource(card_id, resource, options = {})
        paginated_get card_path(card_id, camp(resource)), options
      end

      def delete_card_resource(card_id, resource, *paths)
        delete card_path(card_id, camp(resource), *paths)
      end

      def card_path(card_id, *paths)
        resource_path("cards", card_id, *paths)
      end
    end
  end
end
