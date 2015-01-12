require 'bundler/setup'
Bundler.setup

begin
  require 'simplecov'
  SimpleCov.start
rescue LoadError
  warn "Skipping simplecov"
end
require 'dotenv'
Dotenv.load(File.expand_path("../../.env",  __FILE__))

require 'tacokit'
require 'rspec'
require 'webmock/rspec'

WebMock.disable_net_connect!

RSpec.configure do |config|
  config.before(:suite) do
    warn "Using test_oauth_credentials #{ test_oauth_credentials }" if ENV['DEBUG']
  end

  config.before do
    Tacokit.reset!

    Tacokit.configure do |c|
      c.app_key     = test_trello_app_key
      c.app_secret  = test_trello_app_secret
      c.app_token   = test_trello_app_token
      c.oauth_token  = nil
      c.oauth_secret = nil
    end
  end

  config.around(:each, :silence_warnings) do |example|
    verbose = $VERBOSE
    $VERBOSE = nil
    example.run
    $VERBOSE = verbose
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
    :record                     => :once,
    :re_record_interval         => 60 # 7 days
  }

  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
end

def test_trello_username
  ENV.fetch 'TRELLO_TEST_USERNAME', 'tacokit'
end

def test_trello_app_key
  ENV.fetch 'TRELLO_TEST_APP_KEY', 'tacokit-app-key'
end

def test_trello_app_secret
  ENV.fetch 'TRELLO_TEST_APP_SECRET', 'tacokit-app-secret'
end

def test_trello_app_token
  ENV.fetch 'TRELLO_TEST_APP_TOKEN', 'tacokit-app-token'
end

def test_trello_oauth_token
  ENV.fetch 'TRELLO_TEST_OAUTH_TOKEN', 'tacokit-oauth-token'
end

def test_trello_oauth_secret
  ENV.fetch 'TRELLO_TEST_OAUTH_SECRET', 'tacokit-oauth-secret'
end

def test_org_name
  ENV.fetch 'TRELLO_TEST_ORGANIZATION', 'teamtacokit'
end

def test_org_id
  ENV.fetch 'TRELLO_TEST_ORGANIZATION_ID', '548e30e9683e1923f676ba20'
end

def test_board_link
  'swezQ9XS'
end

def test_board_id
  '548a675581d1d669c9e8184e'
end

def test_client_credentials
  {
    app_key: test_trello_app_key,
    app_token: test_trello_app_token
  }
end

def test_oauth_credentials
  {
    app_key: test_trello_app_key,
    oauth_token: test_trello_oauth_token
  }
end

def app_client
  Tacokit.client
end

def oauth_client
  @oauth_client ||= Tacokit::Client.new(test_oauth_credentials)
end

def tacokit_web_endpoint(*segments)
  File.join(ENV.fetch('TACOKIT_WEB_CLIENT', 'https://tacokit.herokuapp.com'), *segments)
end

def trello_url(url)
  return url if url =~ /^http/

  url = File.join(Tacokit.api_endpoint, url)
  uri = Addressable::URI.parse(url)

  uri.to_s
end

def trello_url_template(url)
  Addressable::Template.new(trello_url(url))
end

def blank?(object)
  object.respond_to?(:empty?) ? !!object.empty? : !object
end

def present?(object)
  !blank?(object)
end

RSpec::Matchers.define :be_present do |expected|
  match do |actual|
    present?(actual)
  end
end
