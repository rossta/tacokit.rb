require 'spec_helper'

describe Tacokit::Client::Notifications do
  def test_notification_id
    '549102431b607566bafc93ab'
  end

  describe "#notification", :vcr do
    it "returns a notification by id" do
      notification = app_client.notification(test_notification_id)
      expect(notification.data).to include("text")
    end

  end

  describe "#notification_field", :vcr do
    it "returns a value" do
      field = app_client.notification_field(test_notification_id, :type)
      expect(field['_value']).to be_present
    end

    it "returns a hash" do
      field = app_client.notification_field(test_notification_id, :data)
      expect(field).to be_a(Hash)
    end

  end

  describe "#notification_resource", :vcr do
    it "returns action entities" do
      entities = app_client.notification_resource(test_notification_id, :entities)

      expect(entities).to be_any
    end

    it "returns notification board" do
      board = app_client.notification_resource(test_notification_id, :board)

      expect(board.name).to be_present
    end
  end

end
