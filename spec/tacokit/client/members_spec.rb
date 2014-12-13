require 'spec_helper'

describe Tacokit::Client::Members do
  let(:client) { Tacokit::Client.new(test_oauth_credentials) }

  describe "member", :vcr do
    it "returns a member" do
      member = Tacokit.client.member("rossta")
      expect(member.username).to eq("rossta")
      expect(member.full_name).to eq("Ross Kaffenberger")
    end

    it "returns authorized self" do
      member = client.member
      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")
    end
  end # .user

end
