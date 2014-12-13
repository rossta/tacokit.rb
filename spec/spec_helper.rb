require 'bundler/setup'
Bundler.setup

require 'dotenv'
Dotenv.load(File.expand_path("../../.env",  __FILE__))

require 'tacokit'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before(:suite) do
    warn "test_oauth_credentials #{ test_oauth_credentials }"
  end

  config.before do
    Tacokit.reset!

    Tacokit.configure do |c|
      c.consumer_key    = test_trello_app_key
      c.consumer_secret = test_trello_app_secret
      c.oauth_token = nil
      c.oauth_token_secret = nil
    end
  end
end

require 'vcr'
VCR.configure do |c|
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<TRELLO_APP_KEY>") do
    test_trello_app_key
  end

  c.filter_sensitive_data("<TRELLO_APP_SECRET>") do
    test_trello_app_secret
  end

  c.filter_sensitive_data("<TRELLO_APP_TOKEN>") do
    test_trello_app_token
  end

  c.filter_sensitive_data("<TRELLO_OAUTH_TOKEN>") do
    test_trello_oauth_token
  end

  c.filter_sensitive_data("<TRELLO_OAUTH_SECRET>") do
    test_trello_oauth_secret
  end

  c.default_cassette_options = {
    :serialize_with             => :json,
    :preserve_exact_body_bytes  => true,
    :decode_compressed_response => true,
    :record                     => :new_episodes
  }

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock # or :fakeweb
end

def test_trello_username
  ENV.fetch 'TRELLO_TEST_USERNAME', 'tacokit'
end

def test_trello_app_key
  ENV.fetch 'TRELLO_TEST_APP_KEY' #, 'api-padawan'
end

def test_trello_app_secret
  ENV.fetch 'TRELLO_TEST_APP_SECRET' #, 'wow_such_password'
end

def test_trello_app_token
  ENV.fetch 'TRELLO_TEST_APP_TOKEN'
end

def test_trello_oauth_token
  ENV.fetch 'TRELLO_TEST_OAUTH_TOKEN'
end

def test_trello_oauth_secret
  ENV.fetch 'TRELLO_TEST_OAUTH_SECRET'
end

def test_client_credentials
  {
    consumer_key: test_trello_app_key,
    app_token: test_trello_app_token
  }
end

def test_oauth_credentials
  {
    consumer_key: test_trello_app_key,
    consumer_secret: test_trello_app_secret,
    oauth_token: test_trello_oauth_token,
    oauth_token_secret: test_trello_oauth_secret
  }
end
