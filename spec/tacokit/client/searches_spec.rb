require 'spec_helper'

describe Tacokit::Client::Searches do

  describe "#search", :vcr do
    it "returns search result" do
      search = app_client.search("taco")

      expect(search.members).to_not be_empty
    end

  end
end
