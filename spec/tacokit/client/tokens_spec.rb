require 'spec_helper'

describe Tacokit::Client::Tokens do

  describe "#token", :vcr do
    it "returns a token for token string" do
      token = app_client.token(test_trello_app_token)

      expect(token.identifier).to be_present
    end
  end

  describe "#create_token_webhook", :vcr do
    it "creates a webhook" do
      webhook = app_client.create_token_webhook \
        test_trello_app_token,
        test_org_id,
        tacokit_web_endpoint("webhook")

      expect(webhook.callback_url).to match(%r{https://[^/]*/webhook})
    end
  end

  describe "#token_field", :vcr do
    it "returns a value" do
      field = app_client.token_field(test_trello_app_token, :date_created)

      expect(field['_value']).to be_present
    end

    it "returns an array" do
      field = app_client.token_field(test_trello_app_token, :permissions)

      expect(field).to be_any
      expect(field.first.read).to be_present
    end
  end

  describe "#token_resource", :vcr do
    it "returns token member" do
      member = app_client.token_resource(test_trello_app_token, :member)

      expect(member).to be_present
    end

    it "returns token webhooks" do
      webhooks = app_client.token_resource(test_trello_app_token, :webhooks)

      expect(webhooks).to be_any
    end
  end
end
