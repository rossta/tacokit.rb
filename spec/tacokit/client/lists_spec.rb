require "spec_helper"

describe Tacokit::Client::Lists do
  def test_list_id
    "548dd948ffd374221926b4c8"
  end

  def test_board_id
    "548a675581d1d669c9e8184e"
  end

  describe "#list", :vcr do
    it "returns a list by id" do
      list = app_client.list(test_list_id)

      expect(list.name).to eq "List 1"
    end
  end

  describe "#list_field", :vcr do
    it "returns a value" do
      field = app_client.list_field(test_list_id, :pos)

      expect(field["_value"]).to be_present
    end
  end

  describe "#list_resource", :vcr do
    it "returns list actions" do
      actions = app_client.list_resource(test_list_id, :actions)

      expect(actions).to be_any
    end

    it "returns list board" do
      board = app_client.list_resource(test_list_id, :board)

      expect(board.name).to be_present
    end

    it "returns list cards" do
      cards = app_client.list_resource(test_list_id, :cards)

      expect(cards).to be_any

      card = cards.first
      expect(card.name).to be_present
    end
  end

  describe "#update_list", :vcr do
    it "updates a list" do
      list = app_client.update_list test_list_id,
        name: "Test List 1"

      expect(list.name).to eq "Test List 1"
      assert_requested :put, trello_url_template("lists/#{test_list_id}{?key,token}")
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
end
