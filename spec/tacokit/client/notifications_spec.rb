require "spec_helper"

describe Tacokit::Client::Notifications do
  # TODO: notifications disappear overtime... need to grab notification id dynamically
  def test_notification_id
    "549102431b607566bafc93ab"
  end

  pending "#notification", :vcr do
    it "returns a notification by id" do
      notification = app_client.notification(test_notification_id)

      expect(notification.data).to include(:text)
    end
  end

  pending "#update_notification", :vcr do
    it "updates a notification" do
      notification = oauth_client.update_notification(test_notification_id, unread: false)

      expect(notification.unread).to be false
      assert_requested :put, trello_url_template("notifications/#{test_notification_id}{?key,token}")
    end
  end
end
