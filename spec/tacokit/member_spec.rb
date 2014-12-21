require 'spec_helper'
require 'ostruct'

module Tacokit
  describe Member do
    let(:client) { OpenStruct.new }
    let(:member) { Tacokit::Member.new(client, username: 'tacokit') }

    describe "#fetch" do
      it "calls member" do
        member = Tacokit::Member.new(client, username: 'tacokit')

        expect(client).to receive(:member).with(
          'tacokit', {}
        ).and_return(
          username: 'tacokit',
          bio: 'A world traveler'
        )

        member.fetch

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
      end
    end

    describe "#save" do
      it "calls update_member" do
        expect(client).to receive(:update_member).with(
          'tacokit',
          username: 'tacokit',
          bio: 'A world traveler',
          full_name: 'Taco Shell'
        ).and_return(
          username: 'tacokit',
          bio: 'A world traveler',
          full_name: 'Taco Shell'
        )

        member.bio = 'A world traveler'
        member.full_name = 'Taco Shell'

        member.save

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
        expect(member.full_name).to eq 'Taco Shell'
      end

      it "accepts params" do
        expect(client).to receive(:update_member).with(
          'tacokit',
          username: 'tacokit',
          email: 'tacokit@example.com'
        ).and_return(
          username: 'tacokit',
          email: 'tacokit@example.com'
        )

        member.save(email: 'tacokit@example.com')

        expect(member.username).to eq 'tacokit'
        expect(member.email).to eq 'tacokit@example.com'
      end
    end

    describe "relations"
  end
end
