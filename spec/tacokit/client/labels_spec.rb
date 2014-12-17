require 'spec_helper'

describe Tacokit::Client::Labels do
  def test_label_id
    '548a675574d650d567d52ad0'
  end

  describe "#label", :vcr do
    it "returns a label by id" do
      label = app_client.label(test_label_id)
      expect(label.name).to match(/Label/)
    end
  end

  describe "#label_resource", :vcr do
    it "returns a board" do
      board = app_client.label_resource(test_label_id, :board)

      expect(board.name).to be_present
    end
  end
end
