require 'spec_helper'

describe Tacokit::Client::Cards do
  def test_card_link
    'k7GHJj7Q'
  end

  def test_card_id
    '548dd95c8ca25ac9d0d9ce71'
  end

  describe "#card", :vcr do
    it "returns a card by short link" do
      card = app_client.card(test_card_link)
      expect(card.name).to eq 'Card 1'
    end

    it "returns a card by id" do
      card = app_client.card(test_card_id)
      expect(card.name).to eq 'Card 1'
    end
  end

  describe "#card_field", :vcr do
    it "returns a value" do
      field = app_client.card_field(test_card_link, :email)
      expect(field['_value']).to be_present
    end

    it "returns an array" do
      field = app_client.card_field(test_card_link, :labels)
      expect(field).to be_any

      label = field.first
      expect(label).to include("color" => "green")
    end

    it "returns a hash" do
      field = app_client.card_field(test_card_link, :labels)
      expect(field.first).to include("color" => "green")
    end
  end

  describe "#card_resource", :vcr do
    it "returns card actions" do
      actions = app_client.card_resource(test_card_link, :actions)

      expect(actions).to be_empty
    end

    it "returns card board" do
      board = app_client.card_resource(test_card_link, :board)

      expect(board.name).to be_present
    end

    it "returns card check item states" do
      states = app_client.card_resource(test_card_link, :check_item_states)

      expect(states).to be_any
      state = states.first
      expect(state.state).to be_present
    end
  end

  describe "#update_card", :vcr do
    it "updates a card" do
      card = app_client.update_card test_card_link,
        desc: 'This card is for Tacokit testing',
        labels: ['blue', 'green']

      expect(card.desc).to eq 'This card is for Tacokit testing'
      expect(card.labels.size).to eq(2)
      assert_requested :put, trello_url_template("cards/#{test_card_link}{?key,token}")
    end

  end

end
