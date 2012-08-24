require "sinatra/base"
require 'json'
require './lib/tickstats/stats'

module TickStats
  class Server < Sinatra::Base

    before do
      content_type 'application/json'
    end

    get '/' do
      "Not a lot to see here, move along now..."
    end

    get '/test' do
      { :abc => 10 }.to_json
    end

    get '/totals' do
      s = Stats.new
      s.load.to_json
    end

    get '/date/' do

    end

  end
end
