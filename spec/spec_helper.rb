require 'bundler/setup'
Bundler.setup

require 'tacoshell'
require 'dotenv'
require 'pry'

Dotenv.load(File.expand_path("../../.env",  __FILE__))

RSpec.configure do |config|
end
