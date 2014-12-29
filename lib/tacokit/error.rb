module Tacokit
  class Error < StandardError
    ConfigurationError = Class.new(Error)

    ClientError = Class.new(Error)

    # Errors
    # Code - Message

    Unauthorized = Class.new(ClientError)

    # 401 - invalid token
    InvalidToken = Class.new(Unauthorized)

    # 401 - invalid key
    InvalidKey   = Class.new(Unauthorized)

    # 401 - unauthorized permission requested
    UnauthorizedPermissionRequested = Class.new(Unauthorized)

    # 403 - Bad member type

    # 404 - model not found
    ResourceNotFound = Class.new(ClientError)

    # 407
    ConnectionFailed = Class.new(ClientError)

  end

end
