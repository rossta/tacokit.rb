require 'spec_helper'

describe Tacokit::Configuration do
  let(:configuration) { Tacokit::Configuration.new }

  it 'has a consumer_key attribute' do
    configuration.consumer_key = 'consumer_key'
    expect(configuration.consumer_key).to eq('consumer_key')
  end

  it 'has a consumer_secret attribute' do
    configuration.consumer_secret = 'consumer_secret'
    expect(configuration.consumer_secret).to eq('consumer_secret')
  end

  it 'has a oauth_token attribute' do
    configuration.oauth_token = 'oauth_token'
    expect(configuration.oauth_token).to eq('oauth_token')
  end

  it 'has a oauth_token_secret attribute' do
    configuration.oauth_token_secret = 'oauth_token_secret'
    expect(configuration.oauth_token_secret).to eq('oauth_token_secret')
  end

  it 'has a developer public key attribute' do
    configuration.consumer_key = 'consumer_key'
    expect(configuration.consumer_key).to eq('consumer_key')
  end

  it 'has a member token attribute' do
    configuration.consumer_secret = 'consumer_secret'
    expect(configuration.consumer_secret).to eq('consumer_secret')
  end

  describe 'initialize' do
    it 'sets key attributes provided as a hash' do
      configuration = Tacokit::Configuration.new \
        consumer_key: 'consumer_key',
        consumer_secret: 'consumer_secret',
        oauth_token: 'oauth_token',
        oauth_token_secret: 'oauth_token_secret'

      expect(configuration.consumer_key).to eq('consumer_key')
      expect(configuration.consumer_secret).to eq('consumer_secret')
      expect(configuration.oauth_token).to eq('oauth_token')
      expect(configuration.oauth_token_secret).to eq('oauth_token_secret')
    end
  end

end
