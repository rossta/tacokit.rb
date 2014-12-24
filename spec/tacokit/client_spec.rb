require 'spec_helper'

describe Tacokit::Client do
  describe "#configuration" do
    it "accepts configuration" do
      opts = { app_key: "joel", app_secret: "0ns0ftw@re" }
      client = Tacokit::Client.new(opts)
      expect(client.app_key).to eq("joel")
      expect(client.app_secret).to eq("0ns0ftw@re")
    end
  end

  describe "#connection", :vcr do
    it "authorized GET request with app key and token params" do
      client = Tacokit::Client.new(test_client_credentials)
      boards = client.get("members/me/boards")

      board = boards.first

      expect(board.name).to eq 'Test Board'
      assert_requested :get, trello_url_template('members/me/boards{?key,token}')
    end
  end

  describe "#inspect" do
    it { expect(Tacokit::Client.new({}).inspect).to match %r{Tacokit::Client} }
  end
end
