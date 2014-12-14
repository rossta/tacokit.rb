require 'spec_helper'

describe Tacokit::Client::Checklists do

  describe "#checklist", :vcr do
    it "returns a checklist by id" do
      checklist = app_client.checklist('548ddd3f5402eb674035334f')
      expect(checklist.name).to eq 'Checklist 1'
    end
  end

end

