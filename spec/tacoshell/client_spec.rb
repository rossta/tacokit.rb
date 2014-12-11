require 'spec_helper'

describe Tacoshell::Client do

  describe "configuration" do
    before do
      @opts = {
        app_key: "joel",
        app_secret: "0ns0ftw@re"
      }
    end

    it "accepts configuration" do
      client = Tacoshell::Client.new(@opts)
      expect(client.app_key).to eq("joel")
      expect(client.app_secret).to eq("0ns0ftw@re")
    end

  end
end
