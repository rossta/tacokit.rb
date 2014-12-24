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

  describe "#create_webhook", :vcr do
    before do
      @webhook = app_client.create_webhook \
        test_trello_app_token,
        test_org_id,
        tacokit_web_endpoint("webhook?create_webhook")
    end

    it "creates a webhook" do
      expect(@webhook.callback_url).to match(%r{https://[^/]*/webhook})
      assert_requested :post, trello_url_template("webhooks{?key,token}")
    end

    after do
      app_client.delete_webhook(@webhook.id)
    end
  end

  describe "#delete_webhook", :vcr do
    before do
      @webhook = app_client.create_webhook \
        test_trello_app_token,
        test_org_id,
        tacokit_web_endpoint("webhook?delete_webhook")
    end

    it "deletes a webhook" do
      app_client.delete_webhook(@webhook.id)

      expect { app_client.webhook(@webhook.id) }.to raise_error(Tacokit::Error::ResourceNotFound)
      assert_requested :delete, trello_url_template("webhooks/#{@webhook.id}{?key,token}")
    end
  end
end
