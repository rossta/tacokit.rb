module Tacokit
  class Error < StandardError
  end

  ClientError = Class.new(Error)
  ConfigurationError = Class.new(ClientError)

end
