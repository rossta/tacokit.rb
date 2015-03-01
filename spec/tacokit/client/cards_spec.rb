require "spec_helper"

describe Tacokit::Client::Cards do
  def test_card_link
    "k7GHJj7Q"
  end

  def test_card_id
    "548dd95c8ca25ac9d0d9ce71"
  end

  describe "#card", :vcr do
    it "returns a card by short link" do
      card = app_client.card(test_card_link)

      expect(card.name).to eq "Card 1"
    end

    it "returns a card by id" do
      card = app_client.card(test_card_id)

      expect(card.name).to eq "Card 1"
    end

    it "returns a card by card resource" do
      card = app_client.card(test_card_link)

      card = app_client.card(card)

      expect(card.name).to eq "Card 1"
    end
  end

  describe "#card_resource", :vcr do
    it "returns card actions" do
      actions = app_client.card_resource(test_card_link, :actions)

      expect(actions).to be_any
    end

    it "returns card board" do
      board = app_client.card_resource(test_card_link, :board)

      expect(board.name).to be_present
    end

    it "returns card check item states" do
      states = app_client.card_resource(test_card_link, :check_item_states)

      expect(states).to be_any

      state = states.first
      expect(state.state).to be_present
    end
  end

  describe "#card_actions", :vcr do
    it "returns card actions" do
      actions = app_client.card_actions(test_card_link)

      expect(actions).to be_any
    end
  end

  describe "#card_board", :vcr do
    it "returns card board" do
      board = app_client.card_board(test_card_link)

      expect(board.name).to eq("Test Board")
    end
  end

  describe "#attachments", :vcr do
    before do
      url = "http://cl.ly/image/2p1x3K1X160b/taco.png"
      @attachment = app_client.create_card_attachment(test_card_link, url, "image/png", name: "taco")
    end

    it "returns attachments" do
      attachments = app_client.attachments(test_card_link)

      expect(attachments.first.name).to eq("taco")
    end

    it "returns an attachment" do
      attachment = app_client.attachment(test_card_link, @attachment.id)

      expect(attachment.name).to eq("taco")
    end

    after do
      app_client.remove_attachment(test_card_link, @attachment.id)
    end
  end

  describe "#checklists", :vcr do
    it "returns check_item_states" do
      check_item_state, _ = app_client.check_item_states(test_card_link)
      expect(check_item_state.state).to eq("complete")
    end

    it "returns checklists" do
      checklist, _ = app_client.checklists(test_card_link)

      expect(checklist.name).to eq("Test Checklist 1")
    end
  end

  describe "#card_list", :vcr do
    it "returns a list" do
      list = app_client.card_list(test_card_link)

      expect(list.name).to eq("Test List 1")
    end
  end

  describe "#card_members", :vcr do
    before do
      @member_1 = app_client.member
      @member_2 = app_client.member("rossta")

      app_client.update_card test_card_link, member_ids: [@member_1.id, @member_2.id]
    end

    it "returns members" do
      members = app_client.card_members(test_card_link)

      expect(members.size).to eq(2)
      expect(members.first.id).to eq(@member_1.id)
      expect(members.last.id).to eq(@member_2.id)
    end

    it "returns members voted" do
      members = app_client.card_members_voted(test_card_link)

      expect(members).to be_empty
    end

    after do
      app_client.update_card test_card_link, member_ids: []
    end
  end

  describe "#stickers", :vcr do
    before do
      @sticker = app_client.add_sticker(test_card_link, "star")
    end

    it "returns stickers" do
      stickers = app_client.stickers(test_card_link)

      expect(stickers.size).to eq(1)
      expect(stickers.first.image).to eq("star")
    end

    after do
      app_client.remove_sticker(test_card_link, @sticker.id)
    end
  end

  describe "#update_card", :vcr do
    before do
      @member_1 = app_client.member
      @member_2 = app_client.member("rossta")
    end

    it "updates a card" do
      card = app_client.update_card test_card_link,
        desc: "This card is for Tacokit testing",
        labels: %w[blue green],
        member_ids: [@member_1.id, @member_2.id]

      expect(card.desc).to eq "This card is for Tacokit testing"
      expect(card.labels.size).to eq(2)
      expect(card.member_ids.size).to eq(2)
      assert_requested :put, trello_url_template("cards/#{test_card_link}{?key,token}")
    end

    after do
      app_client.update_card test_card_link, member_ids: []
    end
  end

  describe "#update_comment", :vcr do
    before do
      @comment = app_client.add_comment(test_card_link, "I'm singing, I'm singing, I'm singing!")
    end

    it "updates a comment" do
      app_client.update_comment(test_card_link, @comment.id, "I'm not singing")
      actions = app_client.card_actions(test_card_link)
      comment = actions.first.data
      expect(comment.text).to eq("I'm not singing")
    end

    after do
      app_client.remove_comment test_card_link, @comment.id
    end
  end

  describe "#update_checklist_item", :vcr do
    before do
      @checklist = app_client.post("cards/#{test_card_link}/checklists", name: "Test Checklist Actions")
      @checkitem = app_client.post("cards/#{test_card_link}/checklist/#{@checklist.id}/checkItem", name: "Working for a living")
    end

    it "updates checklist item" do
      checkitem = app_client.update_check_item(test_card_link, @checklist.id, @checkitem.id, name: "Going on vacation instead")

      expect(checkitem.id).to eq(@checkitem.id)
      expect(checkitem.name).to eq("Going on vacation instead")
    end

    after do
      app_client.delete("cards/#{test_card_link}/checklists/#{@checklist.id}")
    end
  end

  describe "#archive_card", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
    end

    it "archives card" do
      card = app_client.archive_card(@card.id)

      expect(card.closed).to be_truthy
    end

    it "restore card" do
      app_client.archive_card(@card.id)
      card = app_client.restore_card(@card.id)

      expect(card.closed).to be_falsey
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#move_card", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
      @other_board_id = "5496c2a593901c2eb3af5bc6"
      @other_board_list_id = "54b280a866e198c7596baca1"
    end

    it "moves card to board" do
      expect(@card.board_id).to eq(test_board_id)

      card = app_client.move_card(@card.id, board_id: @other_board_id)
      expect(card.board_id).to eq(@other_board_id)
    end

    it "moves card to list" do
      expect(@card.list_id).to eq(test_list_id)

      card = app_client.move_card(@card.id, board_id: @other_board_id)
      expect(card.board_id).to eq(@other_board_id)
    end

    it "moves card to another board list" do
      card = app_client.move_card(@card.id, board_id: @other_board_id, list_id: @other_board_list_id)

      expect(card.board_id).to eq(@other_board_id)
      expect(card.list_id).to eq(@other_board_list_id)
    end

    it "moves card to a new position" do
      bottom_pos = app_client.move_card(@card.id, pos: "bottom").pos

      top_pos = app_client.move_card(@card.id, pos: "top").pos

      expect(bottom_pos).to be > top_pos
    end

    it "raises error if missing options" do
      expect { app_client.move_card(@card.id) }.to raise_error(ArgumentError)
      expect { app_client.move_card @card.id, :foo }.to raise_error(ArgumentError)
      expect { app_client.move_card @card.id, foo: :bar }.to raise_error(ArgumentError)
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#add_member_to_card", :vcr do
    before do
      @member = app_client.member("rossta")
      @card = app_client.card(test_card_link)
    end

    it "adds member to card" do
      members = app_client.add_member_to_card(test_card_link, @member.id)

      expect(members.size).to eq(@card.member_ids.size + 1)
      expect(members.map(&:id)).to include(@member.id)
    end

    after do
      app_client.update_card test_card_link, member_ids: []
    end
  end

  describe "#create_card", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
    end

    it "creates a card" do
      expect(@card.name).to eq "Autocard"
      expect(@card.desc).to eq "This is an autogenerated card"
      assert_requested :post, trello_url_template("cards{?key,token}"),
        body: {
          "idList" => test_list_id,
          "name" => "Autocard",
          "desc" => "This is an autogenerated card"
        }
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#create_card_attachment", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
    end

    it "uploads local file" do
      file_path = File.expand_path("../../../fixtures/taco.png", __FILE__)
      expect(File.exist?(file_path)).to be_truthy

      attachment = app_client.create_card_attachment(@card.id, file_path, "image/png", name: "taco")

      expect(attachment.name).to eq("taco")

      # TODO: mime_type for upload is not persisted on Trello
      # expect(attachment.mime_type).to eq("image/png")
    end

    it "attaches external url" do
      url = "http://cl.ly/image/2p1x3K1X160b/taco.png"
      attachment = app_client.create_card_attachment(@card.id, url, "image/png", name: "taco")

      expect(attachment.name).to eq("taco")

      # TODO: mime_type for upload is not persisted on Trello
      # expect(attachment.mime_type).to eq("image/png")
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#add_comment", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
    end

    it "creates a comment" do
      comment = app_client.add_comment(@card.id, "I'm singing, I'm singing, I'm singing!")

      expect(comment.data.text).to eq "I'm singing, I'm singing, I'm singing!"
      expect(comment.data.card.id).to eq @card.id

      actions = app_client.card_resource(@card.id, "actions")
      expect(actions.map(&:id)).to include(comment.id)
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#start_checklist", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
    end

    it "adds new checklist by name" do
      checklist = app_client.start_checklist(@card.id, "Making a list")

      expect(checklist.name).to eq("Making a list")
      expect(checklist.card_id).to eq(@card.id)
    end

    it "copies a checklist by id" do
      source_checklist = app_client.start_checklist(@card.id, "Making a list")
      app_client.add_checklist_item(source_checklist.id, "Test Checklist Item")

      new_checklist = app_client.copy_checklist(@card.id, source_checklist.id)

      expect(new_checklist.id).to_not eq(source_checklist.id)
      expect(new_checklist.check_items.size).to eq(1)
      expect(new_checklist.check_items.first.name).to eq("Test Checklist Item")

      assert_requested :post, trello_url_template("cards/#{@card.id}/checklists{?key,token}"),
        body: { "idChecklistSource" => source_checklist.id }
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#add_label", :vcr do
    it "adds label to card" do
      label = app_client.add_label(test_card_link, "red")

      expect(label.color).to eq("red")
    end

    after do
      app_client.delete("card/#{test_card_link}/labels/red")
    end
  end

  describe "#vote", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard", desc: "This is an autogenerated card"
      @member_1 = app_client.member
      @member_2 = app_client.member("rossta")
    end

    it "adds a member's vote to card" do
      app_client.vote(@card.id, @member_1.id)

      voted = app_client.card_members_voted(@card.id)
      expect(voted.size).to eq(1)
      expect(voted.first.username).to eq("tacokit")
    end

    after do
      app_client.delete_card(@card.id)
    end
  end

  describe "#delete_card", :vcr do
    before do
      @card = app_client.create_card test_list_id, "Autocard"
    end

    it "deletes a card" do
      app_client.delete_card(@card.id)

      assert_requested :delete, trello_url_template("cards/#{@card.id}{?key,token}")
      expect { app_client.card(@card.id) }.to raise_error(Tacokit::Error::ResourceNotFound)
    end
  end

  describe "#delete_comment", :vcr do
    before do
      @comment = app_client.add_comment(test_card_link, "This is a comment")
    end

    it "deletes comment" do
      # rubocop:disable Style/DotPosition
      expect { app_client.delete_comment(test_card_link, @comment.id) }.
        to change { app_client.card_actions(test_card_link, filter: "comment_card").size }.by(-1)
      # rubocop:enable Style/DotPosition
    end
  end
end
