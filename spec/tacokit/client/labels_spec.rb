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

  describe "#update_label", :vcr do
    it "updates a label" do
      label = app_client.update_label test_label_id, name: 'Test Label 1'

      expect(label.name).to eq 'Test Label 1'
      assert_requested :put, trello_url_template("labels/#{test_label_id}{?key,token}")
    end
  end
end
