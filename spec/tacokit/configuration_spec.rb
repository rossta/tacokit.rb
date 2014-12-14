require 'spec_helper'

describe Tacokit::Configuration do
  let(:configuration) { Tacokit::Configuration.new }

  it 'has a app_key attribute' do
    configuration.app_key = 'app_key'
    expect(configuration.app_key).to eq('app_key')
  end

  it 'has a app_secret attribute' do
    configuration.app_secret = 'app_secret'
    expect(configuration.app_secret).to eq('app_secret')
  end

  it 'has a oauth_token attribute' do
    configuration.oauth_token = 'oauth_token'
    expect(configuration.oauth_token).to eq('oauth_token')
  end

  it 'has a oauth_token_secret attribute' do
    configuration.oauth_secret = 'oauth_secret'
    expect(configuration.oauth_secret).to eq('oauth_secret')
  end

  it 'has a developer public key attribute' do
    configuration.app_key = 'app_key'
    expect(configuration.app_key).to eq('app_key')
  end

  it 'has a member token attribute' do
    configuration.app_secret = 'app_secret'
    expect(configuration.app_secret).to eq('app_secret')
  end

  describe '#initialize' do
    it 'sets key attributes provided as a hash' do
      configuration = Tacokit::Configuration.new \
        app_key: 'app_key',
        app_secret: 'app_secret',
        oauth_token: 'oauth_token',
        oauth_secret: 'oauth_secret'

      expect(configuration.app_key).to eq('app_key')
      expect(configuration.app_secret).to eq('app_secret')
      expect(configuration.oauth_token).to eq('oauth_token')
      expect(configuration.oauth_secret).to eq('oauth_secret')
    end
  end

end
