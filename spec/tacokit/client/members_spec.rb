require 'spec_helper'

describe Tacokit::Client::Members do
  let(:client) { Tacokit::Client.new(test_oauth_credentials) }

  describe "member", :vcr do
    it "returns a member" do
      member = Tacokit.client.member("rossta")
      expect(member.username).to eq("rossta")
      expect(member.full_name).to eq("Ross Kaffenberger")
    end

    it "returns authorized self" do
      member = client.member
      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")
    end

    it "supports query fields as string or array" do
      member = Tacokit.client.member("tacokit",
                                     boards: 'all',
                                     board_fields: 'name,short_url',
                                     fields: ['username', 'full_name'])

      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")

      board = member.boards.first
      expect(board.name).to eq("Test Board")
      expect(board.short_url).to match(%r{^https://trello.com})
    end
  end # .user

end
