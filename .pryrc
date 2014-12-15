require 'bundler/setup'
Bundler.setup
require 'dotenv'
Dotenv.load(
  File.expand_path("../.env",  __FILE__),
  File.expand_path("../.env.development",  __FILE__)
)
