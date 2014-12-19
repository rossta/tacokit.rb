require 'spec_helper'
require 'ostruct'

module Tacokit
  describe Resource do
    let(:client) { OpenStruct.new }

    describe "#initialize" do
      it "handles given attributes" do
        res = Resource.new client, one: 'one', 'two' => :two

        expect(res).to be_a(Resource)
        expect(res.one).to eq 'one'
        expect(res.two).to eq :two
      end

      it "handles nested objects" do
        res = Resource.new client, prefs: { user: { read: 'ftw' }}

        expect(res.prefs.user.read).to eq 'ftw'
        expect(res.prefs).to be_a(Resource)
        expect(res.prefs.user).to be_a(Resource)
      end

      it "has nested collections" do
        res = Resource.new client, labels: [{ color: 'blue' }]

        expect(res.labels.size).to eq 1

        label = res.labels.first
        expect(label.color).to eq 'blue'
        expect(label).to be_a(Resource)
      end

      it "handles clashing keys" do
        res = Resource.new client, client: 1, fields: 2

        expect(res.client).to eq 1
        expect(res.fields).to eq 2

        expect(res._fields).to include(:client, :fields)
        expect(res._fields.size).to eq(2)
      end

      it "has attribute predicates" do
        res = Resource.new client, a: 1, b: true, c: nil, d: false

        expect(res.a?).to be_truthy
        expect(res.b?).to be_truthy
        expect(res.c?).to be_falsey
        expect(res.d?).to be_falsey
      end

      it "has attribute setters" do
        res = Resource.new client, a: 1

        expect(res.a).to eq 1
        expect(res.key?(:a)).to be_truthy

        res.b = 2
        expect(res.b).to eq 2
        expect(res.key?(:b)).to be_truthy
      end

      it "dynamically adds attr methods through getters" do
        res = Resource.new client

        expect(res.respond_to?(:a)).to be_falsey
        expect(res.respond_to?(:a=)).to be_falsey
        expect(res.respond_to?(:a?)).to be_falsey

        res = Resource.new client, a: 1
        expect(res.respond_to?(:a)).to be_truthy
        expect(res.respond_to?(:a=)).to be_truthy
        expect(res.respond_to?(:a?)).to be_truthy
      end

      it "has nillable attribute getters" do
        res = Resource.new client, a: 1

        expect(res.key?(:b)).to be_falsey
        expect(res.respond_to?(:b)).to be_falsey
        expect(res.respond_to?(:b=)).to be_falsey
        expect(res.respond_to?(:b?)).to be_falsey
        expect(res.b).to be_nil
        expect { res.b }.not_to raise_error
      end

      it "dynamically adds attr methods through setters" do
        res = Resource.new client, a: 1

        expect(res.key?(:b)).to be_falsey
        expect(res.respond_to?(:b)).to be_falsey
        expect(res.respond_to?(:b=)).to be_falsey
        expect(res.respond_to?(:b?)).to be_falsey

        res.b = 1

        expect(res.key?(:b)).to be_truthy
        expect(res.respond_to?(:b)).to be_truthy
        expect(res.respond_to?(:b=)).to be_truthy
        expect(res.respond_to?(:b?)).to be_truthy
      end

      it "is enumerable" do
        res = Resource.new client, a: 1, b: 2

        output = []
        res.each { |k,v| output << [k,v] }
        expect(output).to eq [[:a,1],[:b,2]]
      end

      describe "#attrs" do
        it "returns hash of attributes" do
          res = Resource.new client, a: 1

          expect(res.to_attrs).to eq a: 1
        end

        it "returns nested attributes" do
          res = Resource.new client, a: 1, b: [{ c: 2 }]

          expect(res.b).to be_a(Array)
          expect(res.b.first).to be_a(Resource)

          expect(res.to_attrs).to eq(a: 1, b: [{c: 2}])
        end

        it "responds to [] and []=" do
          res = Resource.new client, a: 1

          expect(res.a).to eq 1
          expect(res[:a]).to eq 1
          expect(res['a']).to eq 1

          res[:a] = 2
          expect(res.a).to eq 2
          expect(res[:a]).to eq 2
          expect(res['a']).to eq 2

          res['a'] = 3
          expect(res.a).to eq 3
          expect(res[:a]).to eq 3
          expect(res['a']).to eq 3
        end
      end
    end

  end
end
