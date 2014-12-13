require 'bundler/setup'
Bundler.setup

require 'tacokit'
require 'dotenv'

Dotenv.load(File.expand_path("../../.env",  __FILE__))

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

def test_oauth_credentials
  {
    app_key: test_trello_app_key,
    app_secret: test_trello_app_secret,
    oauth_token: test_trello_oauth_token,
    oauth_token_secret: test_trello_oauth_secret
  }
end
