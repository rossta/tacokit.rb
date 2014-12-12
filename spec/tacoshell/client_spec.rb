require 'spec_helper'

describe Tacoshell::Client do
  describe "configuration" do
    it "accepts configuration" do
      opts = {
        app_key: "joel",
        app_secret: "0ns0ftw@re"
      }
      client = Tacoshell::Client.new(opts)
      expect(client.app_key).to eq("joel")
      expect(client.app_secret).to eq("0ns0ftw@re")
    end
  end

  describe "user" do
    before do
      @opts = {
        app_key: ENV.fetch('TRELLO_APP_KEY'),
        app_secret: ENV.fetch('TRELLO_APP_SECRET')
      }
    end

    let(:client) { Tacoshell::Client.new(@opts) }

    it "retrives user for configured client" do
      expect(client.member("rossta").username).to eq "rossta"
    end
  end
end
