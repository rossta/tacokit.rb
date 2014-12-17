require 'spec_helper'

describe Tacokit::Client::Organizations do

  describe "#organization", :vcr do
    it "returns an organization by id" do
      org = app_client.organization(test_org_name)
      expect(org.name).to eq 'teamtacokit'
    end
  end

  describe "#organization_field", :vcr do
    it "returns a value" do
      field = app_client.organization_field(test_org_name, :desc)
      expect(field['_value']).to eq('Tacokit the organization')
    end

    it "returns an array" do
      field = app_client.organization_field(test_org_name, :premium_features)
      expect(field).to be_empty
    end

    it "returns a hash" do
      field = app_client.organization_field(test_org_name, :prefs)
      expect(field).to include("permission_level" => "public")
    end
  end

  describe "#organization_resource", :vcr do
    it "returns organization actions" do
      actions = app_client.organization_resource(test_org_name, :actions)

      expect(actions).not_to be_empty
    end

    it "returns organization boards" do
      boards = app_client.organization_resource(test_org_name, :boards)

      expect(boards).not_to be_empty

      board = boards.first
      expect(board.name).to be_present
    end

    it "returns organization members" do
      members = app_client.organization_resource(test_org_name, :members)

      expect(members).not_to be_empty

      member = members.first
      expect(member.username).to be_present
    end
  end

  describe "#update_organization", :vcr do
    it "updates a organization" do
      organization = oauth_client.update_organization(test_org_name, desc: 'This organization is for Tacokit collaboration')

      expect(organization.desc).to eq 'This organization is for Tacokit collaboration'
      assert_requested :put, trello_url_template("organizations/#{test_org_name}")
    end
  end
end
