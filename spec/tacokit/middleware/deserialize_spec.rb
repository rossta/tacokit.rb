require 'spec_helper'

module Tacokit
  describe Middleware::Deserialize do
    let(:options) { Hash.new }
    let(:headers) { Hash.new }
    let(:middleware) {
      described_class.new(lambda {|env|
        Faraday::Response.new(env)
      })
    }

    def process(body, content_type = nil, options = {})
      env = {
        :body => body, :request => options,
        :request_headers => Faraday::Utils::Headers.new,
        :response_headers => Faraday::Utils::Headers.new(headers)
      }
      env[:response_headers]['content-type'] = content_type if content_type
      yield(env) if block_given?
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

      it "underscores keys" do
        result = process(helloWorld: 'helloWorld', biggieSmalls: 'biggieSmalls')

        expect(result.body).to include('hello_world' => 'helloWorld')
        expect(result.body).to include('biggie_smalls' => 'biggieSmalls')
      end

      it "coverts id prefix to suffix" do
        result = process('idCard' => "a"*10, 'idBoardPinned' => '123')

        expect(result.body).to eq('card_id' => "a"*10, 'board_pinned_id' => '123')
      end

      it "coverts ids suffix to prefix and pluralizes" do
        result = process('idCards' => "a"*10, 'idBoardsPinned' => ["123"])

        expect(result.body).to eq('card_ids' => "a"*10, 'boards_pinned_ids' => ["123"])
      end
    end
  end
end
