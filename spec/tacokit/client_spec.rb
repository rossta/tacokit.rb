require 'spec_helper'

describe Tacokit::Client do
  describe "configuration" do
    it "accepts configuration" do
      opts = { consumer_key: "joel", consumer_secret: "0ns0ftw@re" }
      client = Tacokit::Client.new(opts)
      expect(client.consumer_key).to eq("joel")
      expect(client.consumer_secret).to eq("0ns0ftw@re")
    end
  end

end
