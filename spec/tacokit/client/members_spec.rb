require "spec_helper"

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

    it "supports query fields as string or array" do
      member = app_client.member "tacokit",
        boards: "all",
        board_fields: "name,short_url",
        fields: %w[ username full_name ]

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
      field = app_client.member_field("tacokit", "full_name")

      expect(field["_value"]).to eq("Taco Kit")
    end

    it "returns an array" do
      field = app_client.member_field("tacokit", :id_organizations)

      expect(field).to include(test_org_id)
    end

    it "returns a resource" do
      field = app_client.member_field("tacokit", :prefs)

      expect(field.to_attrs).to include(color_blind: true)
    end
  end

  describe "#member_resource", :vcr do
    it "returns member actions" do
      actions = app_client.member_resource("tacokit", :actions)

      expect(actions).not_to be_empty

      action = actions.first
      expect(action.member_creator.full_name).to be_present
    end

    it "returns member boards" do
      boards = app_client.member_resource("tacokit", :boards)

      expect(boards).not_to be_empty

      board = boards.first
      expect(board).to be_a(Tacokit::Resource)
      expect(board.name).to be_present
    end

    it "returns member board stars" do
      stars = app_client.member_resource("tacokit", :board_stars)

      expect(stars).not_to be_empty

      star = stars.first
      expect(star.pos).to be_present
    end
  end

  describe "#update_member", :vcr do
    it "updates a member" do
      member = oauth_client.update_member("tacokit", bio: "Tacokit puts the Trello API on Ruby")

      expect(member.bio).to eq "Tacokit puts the Trello API on Ruby"
      assert_requested :put, trello_url_template("members/tacokit{?key,token}")
    end

    it "updates nested resource" do
      member = oauth_client.update_member("tacokit", prefs: { color_blind: true })

      expect(member.prefs.color_blind).to eq true
    end
  end
end
