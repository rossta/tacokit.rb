require "spec_helper"

describe Tacokit::Client::Notifications do
  def test_notification_id
    "549102431b607566bafc93ab"
  end

  describe "#notification", :vcr do
    it "returns a notification by id" do
      notification = app_client.notification(test_notification_id)

      expect(notification.data).to include(:text)
    end
  end

  describe "#notification_field", :vcr do
    it "returns a value" do
      field = app_client.notification_field(test_notification_id, :type)

      expect(field["_value"]).to be_present
    end

    it "returns a resource" do
      field = app_client.notification_field(test_notification_id, :data)

      expect(field).to be_a(Tacokit::Resource)
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

  describe "#update_notification", :vcr do
    it "updates a notification" do
      notification = oauth_client.update_notification(test_notification_id, unread: false)

      expect(notification.unread).to be false
      assert_requested :put, trello_url_template("notifications/#{test_notification_id}{?key,token}")
    end
  end
end
