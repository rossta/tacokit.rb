require 'spec_helper'

describe Tacokit::Client::Labels do

  describe "#label", :vcr do
    it "returns a label by id" do
      label = app_client.label('548a675574d650d567d52ad0')
      expect(label.name).to match(/Label/)
    end
  end

end
