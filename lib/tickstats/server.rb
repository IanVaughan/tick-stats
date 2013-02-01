require "sinatra/base"
require 'json'
require './lib/tickstats/stats'
require 'logger'

module TickStats
  class Server < Sinatra::Base

    configure :development do
      $logger = Logger.new(STDOUT)
    end

    stats = Stats.new($logger)

    before do
      content_type :json
    end

    get '/' do
    end

    get '/totals' do
      s = Stats.new
      s.load.to_json
    end

    get '/info' do
      <<-ENDRESPONSE
        Ruby:    #{RUBY_VERSION}
        Rack:    #{Rack::VERSION}
        Sinatra: #{Sinatra::VERSION}
        #{session.inspect}
      ENDRESPONSE
    end

  end
end
