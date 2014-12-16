require 'spec_helper'

describe Tacokit::Client::Members do

  describe "#member", :vcr do
    it "returns a member" do
      member = app_client.member("rossta")
      expect(member.username).to eq("rossta")

      assert_requested :get, trello_url_template("members/rossta{?key,token}")
    end

    it "returns self" do
      member = app_client.member
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

    context "authenticated" do
      it "returns self" do
        member = oauth_client.member
        expect(member.username).to eq("tacokit")
        expect(member.full_name).to eq("Taco Kit")
        assert_requested :get, trello_url("members/me")
      end
    end

  end

  describe "#member_field", :vcr do
    it "returns a value" do
      field = app_client.member_field('tacokit', 'full_name')
      expect(field['_value']).to eq('Taco Kit')
    end

    it "returns an array" do
      field = app_client.member_field('tacokit', :id_organizations)
      expect(field).to include(test_org_id)
    end

    it "returns a hash" do
      field = app_client.member_field('tacokit', :prefs)
      puts field
      expect(field).to include("color_blind" => false)
    end
  end

  describe "#member_actions", :vcr do
    it "returns member actions" do
      actions = app_client.member_actions('tacokit')

      expect(actions).not_to be_empty

      action = actions.first
      expect(action.member_creator.full_name).to be_present
    end
  end

end
