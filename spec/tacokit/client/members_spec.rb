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

    it "accepts a resource" do
      member = app_client.member

      member = app_client.member(member)

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

  describe "#actions", :vcr do
    it "returns member actions" do
      actions = app_client.actions("tacokit")

      expect(actions).not_to be_empty

      action = actions.first
      expect(action.member_creator.full_name).to be_present

      assert_requested :get, trello_url_template("members/tacokit/actions{?key,token,page}")
    end
  end

  describe "#boards", :vcr do
    it "returns member boards" do
      boards = app_client.boards("tacokit")

      expect(boards).not_to be_empty

      board = boards.first
      expect(board).to be_a(Tacokit::Resource)
      expect(board.name).to be_present

      assert_requested :get, trello_url_template("members/tacokit/boards{?key,token}")
    end

    it "returns for 'me' with options as first arg" do
      boards = app_client.boards(fields: %w[id name])

      expect(boards).not_to be_empty

      board = boards.first
      expect(board.name).to be_present
    end
  end

  describe "#cards", :vcr do
    it "returns member cards" do
      cards = app_client.cards("tacokit")

      expect(cards).to be_empty

      assert_requested :get, trello_url_template("members/tacokit/cards{?key,token}")
    end
  end

  describe "#notifications", :vcr do
    it "returns member notifications" do
      notifications = app_client.notifications("tacokit")

      expect(notifications).to be_empty

      assert_requested :get, trello_url_template("members/tacokit/notifications{?key,token,page}")
    end
  end

  describe "#organizations", :vcr do
    it "returns member organizations" do
      organizations = app_client.organizations("tacokit")

      expect(organizations).not_to be_empty
      org = organizations.first
      expect(org.name).to eq "teamtacokit"

      assert_requested :get, trello_url_template("members/tacokit/organizations{?key,token}")
    end
  end

  describe "#tokens", :vcr do
    it "returns member tokens" do
      tokens = app_client.tokens("tacokit")

      expect(tokens).not_to be_empty
      token = tokens.first
      expect(token.identifier).to be_present

      assert_requested :get, trello_url_template("members/tacokit/tokens{?key,token}")
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
