require './lib/tickstats/server'
require 'sinatra'
require 'rack/test'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false

def app
  TickStats::Server
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
