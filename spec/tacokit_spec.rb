require 'spec_helper'

describe Tacokit do

  describe "method_missing" do
    it "forwards messages to client" do
      expect(Tacokit.client).to receive(:generate_app_key)
      Tacokit.generate_app_key
    end

    it "raises otherwise" do
      expect { Tacokit.no_method }.to raise_error(NoMethodError)
    end

  end
end
