require 'spec_helper'

describe Tacokit::Middleware::Boom do
  let(:app) { Object.new }
  let(:env) { Faraday::Env.new }
  let(:middleware) { described_class.new(app) }

  describe "#on_complete" do

    it "raises 404" do
      env[:status] = 404
      expect{middleware.on_complete(env)}.to raise_error(Tacokit::Error::ResourceNotFound)
    end

    it "raises 407" do
      env[:status] = 407
      expect{middleware.on_complete(env)}.to raise_error(Tacokit::Error::ConnectionFailed)
    end

    it "raises 400" do
      env[:status] = 400
      expect{middleware.on_complete(env)}.to raise_error(Tacokit::Error::ClientError)
    end

    it "raises 401" do
      env[:status] = 401
      expect{middleware.on_complete(env)}.to raise_error(Tacokit::Error::Unauthorized)
    end

    it "does nothing" do
      env[:status] = 200
      expect{middleware.on_complete(env)}.not_to raise_error
    end
  end
end
