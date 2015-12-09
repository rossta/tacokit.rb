require "spec_helper"

describe Tacokit::Client::Webhooks do
  describe "#update_webhook", :vcr do
    before do
      @webhook = app_client.create_webhook \
        test_org_id,
        tacokit_web_endpoint("webhook?create_webhook")
    end

    it "updates a webhook" do
      @webhook = app_client.update_webhook(@webhook.id, description: "This webhook is for Tacokit testing")

      expect(@webhook.description).to eq "This webhook is for Tacokit testing"
      assert_requested :put, trello_url_template("webhooks/#{@webhook.id}{?key,token}")
    end

    after do
      app_client.delete_webhook(@webhook.id)
    end
  end

  describe "#create_webhook", :vcr do
    before do
      @webhook = app_client.create_webhook \
        test_org_id,
        tacokit_web_endpoint("webhook?create_webhook")
    end

    it "creates a webhook" do
      expect(@webhook.callback_url).to match(%r{https://[^/]*/webhook})
      assert_requested :post, trello_url_template("webhooks{?key,token}"),
        body: {
          "callbackURL" => tacokit_web_endpoint("webhook?create_webhook"),
          "idModel" => test_org_id
        }
    end

    after do
      app_client.delete_webhook(@webhook.id)
    end
  end

  describe "#delete_webhook", :vcr do
    before do
      @webhook = app_client.create_webhook \
        test_org_id,
        tacokit_web_endpoint("webhook?delete_webhook")
    end

    it "deletes a webhook" do
      app_client.delete_webhook(@webhook.id)

      expect { app_client.token_resource(test_trello_app_token, :webhooks, @webhook.id) }.to raise_error(Tacokit::Error::ResourceNotFound)
      assert_requested :delete, trello_url_template("webhooks/#{@webhook.id}{?key,token}")
    end
  end
end
