require 'spec_helper'

describe Tacokit::Client::Organizations do

  describe "#organization", :vcr do
    it "returns an organization by id" do
      org = app_client.organization(test_organization_id)
      expect(org.name).to eq 'teamtacokit'
    end
  end

end
