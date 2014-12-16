require 'spec_helper'

describe Tacokit::Client::Types do

  describe "#type", :vcr do
    it "returns a type by id" do
      type = app_client.type(test_org_name)
      expect(type.type).to eq 'organization'
    end
  end
end
