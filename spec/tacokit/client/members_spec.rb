require 'spec_helper'

describe Tacokit::Client::Members do

  describe "member", :vcr do
    it "returns a member" do
      member = app_client.member("rossta")
      expect(member.username).to eq("rossta")
      expect(member.full_name).to eq("Ross Kaffenberger")
    end

    it "returns token authorized self" do
      member = app_client.member
      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")
    end

    it "returns oauth authorized self" do
      member = oauth_client.member
      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")
    end

    it "raises error for missing token" do
      app_client.configuration.app_token = nil
      expect { app_client.member }.to raise_error
    end

    it "supports query fields as string or array" do
      member = app_client.member("tacokit",
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

  describe "member_field", :vcr do
    it "returns a member field" do
      field = app_client.member_field('tacokit', 'full_name')
      expect(field).to eq('Taco Kit')
    end
  end

  describe "member_actions", :vcr do
    it "returns member actions" do
      actions = app_client.member_actions('tacokit')

      expect(actions).not_to be_empty

      action = actions.first
      expect(action.member_creator.full_name).to be_present
    end
  end

end
