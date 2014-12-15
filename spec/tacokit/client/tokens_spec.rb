require 'spec_helper'

describe Tacokit::Client::Tokens do

  describe "#token", :vcr do
    it "returns a token by id" do
      token = app_client.token(test_trello_app_token)
      expect(token.identifier).to be_present
    end
  end

end
