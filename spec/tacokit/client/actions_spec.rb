require 'spec_helper'

describe Tacokit::Client::Actions do
  def test_action_id
    '548e3153ea7ca8f9cd3cb77b'
  end

  describe "#action", :vcr do
    # board id: '548a675581d1d669c9e8184e'
    # board shortLink: 'swezQ9XS'

    it "returns a token authorized action" do
      action = app_client.action(test_action_id)

      expect(action.type).to be_present
      expect(action.data).to be_any
    end

    it 'returns oauth authorized board' do
      action = oauth_client.action(test_action_id)

      expect(action.type).to be_present
      expect(action.data).to be_any
    end
  end

end
