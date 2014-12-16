require 'spec_helper'

describe Tacokit::Client::Boards do
  def test_board_link
    'swezQ9XS'
  end

  describe "#board", :vcr do
    # board id: '548a675581d1d669c9e8184e'
    # board shortLink: 'swezQ9XS'

    it "returns a token authorized board" do
      board = app_client.board(test_board_link)

      expect(board.name).to eq('Test Board')
    end

    it 'returns oauth authorized board' do
      board = oauth_client.board(test_board_link)

      expect(board.name).to eq('Test Board')
    end
  end

  describe "#board_field", :vcr do
    it "returns a value" do
      name = app_client.board_field(test_board_link, :name)
      expect(name['_value']).to eq('Test Board')
    end

    it "returns an array" do
      power_ups = app_client.board_field(test_board_link, :power_ups)
      expect(power_ups).to eq([])
    end

    it "returns a hash" do
      label_names = app_client.board_field(test_board_link, :label_names)
      expect(label_names).to include("green", "yellow", "orange")
    end
  end

  describe "#board_resource", :vcr do
    it "returns board actions" do
      actions = app_client.board_resource(test_board_link, :actions)

      expect(actions).not_to be_empty

      action = actions.first
      expect(action.member_creator.full_name).to be_present
    end

    it "returns board members" do
      members = app_client.board_resource(test_board_link, :members)

      expect(members).not_to be_empty

      member = members.first
      expect(member.username).to be_present
    end

    it "returns board cards" do
      cards = app_client.board_resource(test_board_link, :cards)

      expect(cards).not_to be_empty

      card = cards.first
      expect(card.pos).to be_present
    end
  end

end
