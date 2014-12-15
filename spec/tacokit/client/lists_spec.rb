require 'spec_helper'

describe Tacokit::Client::Lists do

  describe "#list", :vcr do
    it "returns a list by id" do
      list = app_client.list('548dd948ffd374221926b4c8')
      expect(list.name).to eq 'List 1'
    end
  end

end
