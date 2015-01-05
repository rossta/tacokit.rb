require 'spec_helper'

describe Tacokit::Resource do

  def build_resource(attrs = {})
    described_class.new(attrs)
  end

  describe "#initialize" do
    it "responds to given attributes" do
      resource = build_resource(one: 'one', 'two' => :two)

      expect(resource.one).to eq 'one'
      expect(resource.two).to eq :two
    end

    it "responds to deep attributes" do
      resource = build_resource(deep: { merge: { attribute: 'ftw' }})

      expect(resource.deep.merge.attribute).to eq 'ftw'
    end

  end
end
