require 'spec_helper'

describe Tacokit::Client::Members do

  describe "member", :vcr do
    it "returns a member" do
      member = Tacokit.client.member("tacokit")
      expect(member.username).to eq("tacokit")
      expect(member.full_name).to eq("Taco Kit")
    end
  end # .user

end
