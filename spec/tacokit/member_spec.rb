require 'spec_helper'
require 'ostruct'

module Tacokit
  describe Member do
    let(:client) { Tacokit.client }
    let(:resource) { Resource.new(username: 'tacokit') }
    let(:member) { Member.new(client, resource) }

    describe "#fetch" do
      it "calls member" do
        expect(client).to receive(:member).with('tacokit', {}).
          and_return(Resource.new username: 'tacokit', bio: 'A world traveler')

        member.fetch

        expect(member.username).to eq 'tacokit'
        expect(member.bio).to eq 'A world traveler'
      end

      it "accepts params" do
        expect(client).to receive(:member).with('tacokit', boards: true).
          and_return(Resource.new username: 'tacokit', bio: 'A world traveler', boards: [])

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
        let(:resource) { Resource.new(username: 'tacokit', boards: [{id: "1234", name: "Board 1"}]) }

        it "returns array of Board resources" do
          board = member.boards.first
          expect(board).to be_a(Board)
          expect(board.id).to eq "1234"
          expect(board.name).to eq "Board 1"
        end

        it "through setter" do
          member.boards = [{id: "5678", name: "Board 2"}]
          board = member.boards.first
          expect(board).to be_a(Board)
          expect(board.id).to eq "5678"
          expect(board.name).to eq "Board 2"
        end
      end
    end
  end
end
