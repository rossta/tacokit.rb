require "spec_helper"

describe Tacokit::Client::Lists do
  def test_list_id
    "548dd948ffd374221926b4c8"
  end

  def test_board_id
    "548a675581d1d669c9e8184e"
  end

  def test_alternate_list_id
    "54f3724e8a0bbe01a80f8712"
  end

  def test_alternate_board_id
    "54f371b4086781e1a71b6111"
  end

  describe "#list", :vcr do
    it "returns a list by id" do
      list = app_client.list(test_list_id)

      expect(list.name).to eq "List 1"
    end
  end

  describe "#list_actions", :vcr do
    it "returns list actions" do
      actions = app_client.list_actions(test_list_id)

      expect(actions).to be_any
    end
  end

  describe "#list_cards", :vcr do
    it "returns list cards" do
      cards = app_client.list_cards(test_list_id)

      expect(cards).to be_any

      card = cards.first
      expect(card.name).to be_present
    end
  end

  describe "#list_board", :vcr do
    it "returns list board" do
      board = app_client.list_board(test_list_id)

      expect(board.name).to be_present
    end
  end

  describe "#update_list", :vcr do
    it "updates a list" do
      list = app_client.update_list test_list_id, name: "Test List 1"

      expect(list.name).to eq "Test List 1"
      assert_requested :put, trello_url_template("lists/#{test_list_id}{?key,token}")
    end

    after do
      app_client.update_list test_list_id, name: "List 1"
    end
  end

  describe "#create_list", :vcr do
    before do
      @list = app_client.create_list test_board_id, "Autolist", pos: "bottom"
    end

    it "creates a list" do
      expect(@list.name).to eq "Autolist"
      expect(@list.pos).to be >= 1
      assert_requested :post, trello_url_template("lists{?key,token}"),
        body: {
          "name" => "Autolist",
          "pos" => "bottom",
          "idBoard" => test_board_id
        }
    end

    after do
      app_client.update_list @list.id, closed: true
    end
  end

  describe "#archive_list_cards", :vcr do
    before do
      @list = app_client.create_list test_board_id, "Autolist", pos: "bottom"
      @card = app_client.create_card @list.id, "Test card"
    end

    it "should archive cards in list" do
      app_client.archive_list_cards(@list.id)

      card = app_client.card(@card.id)
      expect(card.closed?).to be_truthy
    end

    after do
      app_client.update_list @list.id, closed: true
    end
  end

  describe "#move_list_cards", :vcr do
    before do
      @list = app_client.create_list test_board_id, "Autolist", pos: "bottom"
      @card = app_client.create_card @list.id, "Test card"
    end

    it "should move cards in list" do
      app_client.move_list_cards @list.id, test_alternate_list_id, test_alternate_board_id

      source = app_client.list_cards(@list.id)
      expect(source).to be_empty

      destination = app_client.list_cards(test_alternate_list_id)
      expect(destination.size).to eq(1)

      card = destination.first
      expect(card.list_id).to eq test_alternate_list_id
    end

    after do
      app_client.delete_card @card.id
      app_client.update_list @list.id, closed: true
    end
  end
end
