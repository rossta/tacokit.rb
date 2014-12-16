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

end
