require 'spec_helper'

describe Tacokit::Client::Organizations do

  describe "#organization", :vcr do
    it "returns an organization by id" do
      org = app_client.organization('548e30e9683e1923f676ba20')
      expect(org.name).to eq 'teamtacokit'
    end
  end

end
