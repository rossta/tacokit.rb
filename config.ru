require 'bundler/setup'
Bundler.setup
require 'dotenv'
Dotenv.load(File.expand_path("../.env",  __FILE__))

require './app'
run TrelloOauth
