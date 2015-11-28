require "spec_helper"

describe Tacokit::Configuration do
  let(:configuration) { Tacokit::Configuration.new }

  it "has an app_key attribute" do
    configuration.app_key = "app_key"
    expect(configuration.app_key).to eq("app_key")
  end

  it "has an app_secret attribute" do
    configuration.app_secret = "app_secret"
    expect(configuration.app_secret).to eq("app_secret")
  end

  it "has an oauth_token attribute" do
    configuration.oauth_token = "oauth_token"
    expect(configuration.oauth_token).to eq("oauth_token")
  end

  it "has an oauth_token_secret attribute" do
    configuration.oauth_secret = "oauth_secret"
    expect(configuration.oauth_secret).to eq("oauth_secret")
  end

  it "has a developer public key attribute" do
    configuration.app_key = "app_key"
    expect(configuration.app_key).to eq("app_key")
  end

  it "has a member token attribute" do
    configuration.app_secret = "app_secret"
    expect(configuration.app_secret).to eq("app_secret")
  end

  it "exposes middleware stack" do
    handlers = configuration.stack.handlers
    expect(handlers.size).to eq(6)
    [FaradayMiddleware::EncodeJson,
     Faraday::Request::Multipart,
     Faraday::Request::UrlEncoded,
     FaradayMiddleware::ParseJson,
     Tacokit::Middleware::RaiseError,
     Faraday::Adapter::NetHttp].each do |middleware|
      expect(handlers).to include(middleware), "handlers did not include #{middleware}"
     end
  end

  it "has configurable middleware stack" do
    test_middleware = Class.new(Faraday::Middleware)

    configuration.stack do |conn|
      conn.use test_middleware
    end

    expect(configuration.stack.handlers.size).to eq(7)
    expect(configuration.stack.handlers.last).to eq(test_middleware)
  end

  describe "#initialize" do
    it "sets key attributes provided as a hash" do
      configuration = Tacokit::Configuration.new \
        app_key: "app_key",
        app_secret: "app_secret",
        oauth_token: "oauth_token",
        oauth_secret: "oauth_secret"

      expect(configuration.app_key).to eq("app_key")
      expect(configuration.app_secret).to eq("app_secret")
      expect(configuration.oauth_token).to eq("oauth_token")
      expect(configuration.oauth_secret).to eq("oauth_secret")
    end
  end
end
