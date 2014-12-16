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
      webhook = app_client.create_token_webhook(
        test_trello_app_token,
        '548e30e9683e1923f676ba20', # tacokit org id
        tacokit_web_endpoint("webhook")
      )

      expect(webhook.callback_url).to match(%r{https://[^/]*/webhook})
    end
  end
end
