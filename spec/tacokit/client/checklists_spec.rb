require 'spec_helper'

describe Tacokit::Client::Checklists do
  def test_checklist_id
    '548ddd3f5402eb674035334f'
  end

  def test_card_id
    '548dd95c8ca25ac9d0d9ce71'
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

  describe "#update_checklist", :vcr do
    it "updates a checklist" do
      checklist = app_client.update_checklist test_checklist_id,
        name: 'Test Checklist 1'

      expect(checklist.name).to eq 'Test Checklist 1'
      assert_requested :put, trello_url_template("checklists/#{test_checklist_id}{?key,token}")
    end
  end

  describe "#create_checklist", :vcr do
    before do
      @checklist = app_client.create_checklist test_card_id, "Autochecklist", pos: "top"
    end

    it "creates a checklist" do
      expect(@checklist.name).to eq "Autochecklist"
      expect(@checklist.pos).to be >= 1
      assert_requested :post, trello_url_template("checklists{?key,token}"),
        body: {
          'name' => 'Autochecklist',
          'pos' => 'top',
          'idCard' => test_card_id
        }
    end

    after do
      app_client.delete_checklist(@checklist.id)
    end
  end

  describe "#delete_checklist", :vcr do
    before do
      @checklist = app_client.create_checklist test_card_id, "Autochecklist"
    end

    it "deletes a checklist" do
      app_client.delete_checklist(@checklist.id)

      expect { app_client.checklist(@checklist.id) }.to raise_error(Tacokit::Error::ResourceNotFound)
      assert_requested :delete, trello_url_template("checklists/#{@checklist.id}{?key,token}")
    end
  end
end
