require 'forwardable'

module Tacoshell
  class Client
    extend Forwardable

    def_delegators :configuration, *Configuration.keys

    def initialize(options = {})
      self.configuration.options = options
    end

    def configuration
      @configuration ||= Configuration.new
    end

  end
end
