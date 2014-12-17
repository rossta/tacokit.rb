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
end
