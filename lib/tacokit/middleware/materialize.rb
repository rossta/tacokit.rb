module Tacokit
  module Middleware
    class Materialize < Faraday::Response::Middleware

      attr_accessor :client

      def initialize(app = nil, options = {})
        super(app)
        self.client = options[:client]
      end

      def parse(body)
        case body
        when Hash
          self.class.resource_class.new(client, body)
        when Array
          body.map { |value| parse(value) }
        else
          body
        end
      end

      def self.resource_class
        Tacokit::Resource
      end

    end
  end
end
