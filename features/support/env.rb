$LOAD_PATH << File.expand_path('../../../lib/tickstats', __FILE__)
require 'server'
require 'sinatra'
require 'rack/test'

require 'webrat'

Webrat.configure do |config|
   config.mode = :rack
end

class SomeWorld
  require 'test/unit'

  set :environment, :test

  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  def app
    Rack::Builder.new do
      run TickStats::Server
    end
  end
end

World do
  SomeWorld.new
end
