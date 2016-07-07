require "spec_helper"
require "launchy"

describe Tacokit::Authorization do
  before do
    allow(Launchy).to receive(:open)
  end

  describe "#get_app_key" do
    it "launches app key endpoint" do
      expect(Launchy).to receive(:open).with("https://trello.com/1/app-key")

      Tacokit.client.get_app_key
    end

    it "doesn't require launchy", :silence_warnings do
      allow(Launchy).to receive(:open).and_raise(LoadError)

      Tacokit.client.get_app_key
    end
  end

  describe "#authorize" do
    it "launches authorize endpoint" do
      authorize_url = "https://trello.com/1/authorize?key=#{test_trello_app_key}&name=Tacokit&response_type=token"
      expect(Launchy).to receive(:open).with(authorize_url)

      Tacokit.client.authorize
    end
  end

  describe "#authorize_url" do
    it "returns the url to authorize user via web flow" do
      uri = Addressable::URI.parse Tacokit.authorize_url(
        app_name: "Tacokit", key: test_trello_app_key, scope: "read"
      )

      expect(uri.scheme).to eq "https"
      expect(uri.host).to eq "trello.com"

      params = uri.query_values
      expect(params["key"]).to eq test_trello_app_key
      expect(params["app_name"]).to eq "Tacokit"
      expect(params["response_type"]).to eq "token"
      expect(params["scope"]).to eq "read"
    end
  end
end
