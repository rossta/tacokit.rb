require 'spec_helper'

describe Tacokit::Client do
  describe "configuration" do
    it "accepts configuration" do
      opts = {
        app_key: "joel",
        app_secret: "0ns0ftw@re"
      }
      client = Tacokit::Client.new(opts)
      expect(client.app_key).to eq("joel")
      expect(client.app_secret).to eq("0ns0ftw@re")
    end
  end

end
