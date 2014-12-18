require 'spec_helper'

describe Tacokit::Request::Serialize do
  let(:middleware) { described_class.new(lambda{|env| env}) }

  def process(body, content_type = nil)
    env = {:body => body, :request_headers => Faraday::Utils::Headers.new}
    env[:request_headers]['content-type'] = content_type if content_type
    middleware.call(Faraday::Env.from(env))
  end

  context "no body"
  context "empty body"
  context "string body"
  context "hash body"
  context "empty hash body"

  describe "transform keys from Ruby style to Trello style" do
    it "lower camelizes keys" do
      result = process(hello_world: 'hello_world', biggie_smalls: 'biggie_smalls')

      expect(result.body).to include('helloWorld' => 'hello_world')
      expect(result.body).to include('biggieSmalls' => 'biggie_smalls')
    end

    it "flattens nested keys" do
      result = process(prefs: { 'showSidebar' => true })

      expect(result.body).to eq('prefs/showSidebar' => true)
    end

    it "coverts id suffix to prefix"
  end

end
