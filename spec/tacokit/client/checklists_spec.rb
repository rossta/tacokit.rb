require 'spec_helper'

describe Tacokit::Client::Checklists do
  def test_checklist_id
    '548ddd3f5402eb674035334f'
  end

  describe "#checklist", :vcr do
    it "returns a checklist by id" do
      checklist = app_client.checklist(test_checklist_id)
      expect(checklist.name).to eq 'Checklist 1'
    end
  end

  describe "#checklist_field", :vcr do
    it "returns a value" do
      field = app_client.checklist_field(test_checklist_id, :pos)
      expect(field['_value']).to be_present
    end
  end

  describe "#checklist_resource", :vcr do
    it "returns checklist actions" do
      items = app_client.checklist_resource(test_checklist_id, :check_items)

      expect(items).to be_any
      expect(items.first.state).to be_present
    end

    it "returns checklist board" do
      board = app_client.checklist_resource(test_checklist_id, :board)

      expect(board.name).to be_present
    end

  end
end
