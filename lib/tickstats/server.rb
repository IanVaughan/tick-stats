require "sinatra/base"
require 'json'
require './lib/tickstats/stats'

module TickStats
  class Server < Sinatra::Base

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
