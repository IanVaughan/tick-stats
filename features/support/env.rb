$LOAD_PATH << File.expand_path('../../../lib/tickstats', __FILE__)
require 'server'

require 'sinatra'
require 'rack/test'


# ENV['RACK_ENV'] = 'test'

require 'webrat'

Webrat.configure do |config|
  # config.mode = :mechanize
   config.mode = :rack
end

# World(Webrat::Methods)
# World(Webrat::Matchers)

class SomeWorld
  require 'test/unit'

  set :environment, :test

  include Rack::Test::Methods
  include Webrat::Methods
  include Webrat::Matchers

  # include Capybara
  # include RSpec::Expectations
  # include RSpec::Matchers
  def app
    Rack::Builder.new do
      run TickStats::Server
    end
  end
end

World do
  SomeWorld.new
end
