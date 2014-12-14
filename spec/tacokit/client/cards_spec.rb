require 'spec_helper'

describe Tacokit::Client::Cards do

  describe "#card", :vcr do
    it "returns a card by short link" do
      card = app_client.card('k7GHJj7Q')
      expect(card.name).to eq 'Card 1'
    end

    it "returns a card by id" do
      card = app_client.card('548dd95c8ca25ac9d0d9ce71')
      expect(card.name).to eq 'Card 1'
    end
  end

end
