require 'spec_helper'

describe Tacokit::Request::Serialize do
  let(:middleware) { described_class.new(lambda{|env| env}) }

  def process(body, content_type = nil)
    env = {:body => body, :request_headers => Faraday::Utils::Headers.new}
    env[:request_headers]['content-type'] = content_type if content_type
    middleware.call(Faraday::Env.from(env))
  end

  it "does not change no body" do
    result = process(nil)
    expect(result.body).to be_nil
  end

  it "does not change empty body" do
    result = process('')
    expect(result.body).to eq ''
  end

  it "does not change string body" do
    result = process('{a: 1}')
    expect(result.body).to eq '{a: 1}'
  end

  it "does not change empty hash body" do
    result = process({})
    expect(result.body).to eq({})
  end

  context "hash body" do
    it "it stringifies keys" do
      result = process(hello: 'world')

      expect(result.body).to eq 'hello' => 'world'
    end

    it "lower camelizes keys" do
      result = process(hello_world: 'hello_world', biggie_smalls: 'biggie_smalls')

      expect(result.body).to include('helloWorld' => 'hello_world')
      expect(result.body).to include('biggieSmalls' => 'biggie_smalls')
    end

    it "flattens nested keys" do
      result = process(prefs: { 'showSidebar' => true })

      expect(result.body).to eq('prefs/showSidebar' => true)
    end

    it "coverts id suffix to prefix" do
      result = process('card_id' => "a"*10)

      expect(result.body).to eq('idCard' => "a"*10)
    end

    it "coverts ids suffix to prefix and pluralizes" do
      result = process('card_ids' => "a"*10)

      expect(result.body).to eq('idCards' => "a"*10)
    end
  end
end
