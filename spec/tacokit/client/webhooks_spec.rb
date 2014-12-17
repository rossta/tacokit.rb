require 'spec_helper'

describe Tacokit::Client::Webhooks do
  def test_webhook_id
    '5491ff14d60e03635c260393'
  end

  describe "#webhook", :vcr do
    it "returns a webhook by short link" do
      webhook = app_client.webhook(test_webhook_id)

      expect(webhook.callback_url).to match(%r{https://[^/]*/webhook})
    end
  end

  describe "#webhook_field", :vcr do
    it "returns a value" do
      field = app_client.webhook_field(test_webhook_id, :callback_url)

      expect(field['_value']).to be_present
    end
  end

  describe "#update_webhook", :vcr do
    it "updates a webhook" do
      webhook = app_client.update_webhook(test_webhook_id, description: 'This webhook is for Tacokit testing')

      expect(webhook.description).to eq 'This webhook is for Tacokit testing'
      assert_requested :put, trello_url_template("webhooks/#{test_webhook_id}{?key,token}")
    end
  end
end
