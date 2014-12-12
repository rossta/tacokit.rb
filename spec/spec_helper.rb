require 'bundler/setup'
Bundler.setup

require 'tacokit'
require 'dotenv'
require 'pry'

Dotenv.load(File.expand_path("../../.env",  __FILE__))

RSpec.configure do |config|
  config.before do
    Tacokit.reset!

    Tacokit.configure do |c|
      c.app_key = test_trello_app_key
      c.app_secret = test_trello_app_secret
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

def test_app_credentials
  { app_key: test_trello_app_key, app_secret: test_trello_app_secret }
end
