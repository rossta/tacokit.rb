require 'spec_helper'

describe Tacokit::Client do
  describe "#configuration" do
    it "accepts configuration" do
      opts = { consumer_key: "joel", consumer_secret: "0ns0ftw@re" }
      client = Tacokit::Client.new(opts)
      expect(client.consumer_key).to eq("joel")
      expect(client.consumer_secret).to eq("0ns0ftw@re")
    end
  end

  describe "#connection" do
    it "authorized GET request with app key and token params" do
      # https://api.trello.com/1/members/me/boards?key=3dca2797d175d70a1252cb502a5e49b9&token=TOKEN
      client = Tacokit::Client.new(test_client_credentials)
      boards = client.get("members/me/boards")

      puts boards
      board = boards.first
      expect(board.name).to eq 'Test Board'
    end
  end
end
