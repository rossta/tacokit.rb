require 'spec_helper'
require 'ostruct'

module Tacokit
  describe Member do
    let(:client) { OpenStruct.new }
    let(:resource) { Resource.new(client, username: 'tacokit') }
    let(:member) { Member.new(resource) }

    describe "self.fetch" do
      it "returns a member resource" do
        expect(client).to receive(:member).with(
          'tacokit', {}
        ).and_return(Resource.new client,
          username: 'tacokit',
          bio: 'A world traveler'
        )

        member = Member.fetch(client, 'tacokit')

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
      end
    end

    describe "#fetch" do
      it "calls member" do
        expect(client).to receive(:member).with(
          'tacokit', {}
        ).and_return(Resource.new client,
          username: 'tacokit',
          bio: 'A world traveler'
        )

        member.fetch

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
      end

      it "accepts params" do
        expect(client).to receive(:member).with(
          'tacokit', boards: true
        ).and_return(Resource.new client,
          username: 'tacokit',
          bio: 'A world traveler',
          boards: []
        )

        member.fetch(boards: true)

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
        expect(member.boards).to eq []
      end
    end

    describe "#sync" do
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

        member.sync

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

        member.sync(email: 'tacokit@example.com')

        expect(member.username).to eq 'tacokit'
        expect(member.email).to eq 'tacokit@example.com'
      end
    end

    describe "#fetch_field" do
      it "calls member_field" do
        expect(client).to receive(:member_field).with('tacokit', 'bio').and_return('A world traveler')
        expect(member.fetch_field('bio')).to eq 'A world traveler'
        expect(member.bio).to eq 'A world traveler'
      end
    end

    describe "#fetch_relation" do
      it "calls member_resource" do
        expect(client).to receive(:member_resource).with('tacokit', :boards).and_return([])
        expect(member.fetch_relation(:boards)).to eq []
        expect(member.boards).to eq []
      end
    end

    describe "relations" do
      describe "#boards" do
        it "returns array of Board resources" do
          member.boards = [{id: "1234", name: "Board 1"}]

          board = member.boards.first
          expect(board).to be_a(Board)
          expect(board.id).to eq "1234"
          expect(board.name).to eq "Board 1"
        end
      end
    end
  end
end
