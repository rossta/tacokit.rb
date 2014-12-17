require 'spec_helper'

describe Tacokit::Client::Webhooks do
  def test_webhook_id
    '549036896bf729c446859b22'
  end

  describe "#webhook", :vcr do
    it "returns a webhook by short link" do
      webhook = app_client.webhook(test_webhook_id)
      expect(webhook.callback_url).to match(%r{https://[^/]*/webhook})
    end

  end

end
