require "spec_helper"

describe Tacokit::Client::Labels do
  def test_label_id
    "548a675574d650d567d52ad0"
  end

  def test_board_id
    "548a675581d1d669c9e8184e"
  end

  describe "#label", :vcr do
    it "returns a label by id" do
      label = app_client.label(test_label_id)
      expect(label.name).to match(/Label/)
    end
  end

  describe "#update_label", :vcr do
    it "updates a label" do
      label = app_client.update_label test_label_id, name: "Test Label 1"

      expect(label.name).to eq "Test Label 1"
      assert_requested :put, trello_url_template("labels/#{test_label_id}{?key,token}")
    end
  end

  describe "#create_label", :vcr do
    before do
      @label = app_client.create_label test_board_id, "Test Label X", "sky"
    end

    it "creates a label" do
      expect(@label.name).to eq "Test Label X"
      expect(@label.color).to eq "sky"

      assert_requested :post, trello_url_template("labels{?key,token}"),
        body: {
          "idBoard" => test_board_id,
          "name" => "Test Label X",
          "color" => "sky"
        }
    end

    after do
      app_client.delete_label(@label.id)
    end
  end

  describe "#delete_label", :vcr do
    before do
      @label = app_client.create_label test_board_id, "Test Label X", "sky"
    end

    it "deletes a label" do
      app_client.delete_label(@label.id)

      assert_requested :delete, trello_url_template("labels/#{@label.id}{?key,token}")
      expect { app_client.label(@label.id) }.to raise_error(Tacokit::Error::ResourceNotFound)
    end
  end
end
