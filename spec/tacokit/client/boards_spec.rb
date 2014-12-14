require 'spec_helper'

describe Tacokit::Client::Boards do

  describe "#board", :vcr do
    it "returns a token authorized board" do
      board = app_client.board("548a675581d1d669c9e8184e")

      expect(board.name).to eq("Test Board")
    end

    it "returns oauth authorized board" do
      board = oauth_client.board("548a6696b3b9918beb144b08")

      expect(board.name).to eq("Welcome Board")
    end
  end

end
