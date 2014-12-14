require 'spec_helper'

describe Tacokit::Client::Labels do

  describe "#labels", :vcr do
    it "returns a label by id" do
      label = app_client.label('548a675574d650d567d52ad5')
      expect(label.name).to match(/Label/)
    end
  end

end
