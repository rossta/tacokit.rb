module Tacokit
  class Error < StandardError
  end

  ConfigurationError = Class.new(Error)

  ClientError = Class.new(Error)

  # Errors
  # Code - Message

  # 401 - invalid token
  InvalidToken = Class.new(ClientError)

  # 401 - invalid key
  InvalidKey   = Class.new(ClientError)

  # 401 - unauthorized permission requested
  UnauthorizedPermissionRequested = Class.new(ClientError)

  # 404 - model not found
  ResourceNotFound = Class.new(ClientError)

end
