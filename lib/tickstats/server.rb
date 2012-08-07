require "sinatra/base"
require 'json'

module TickStats
  class Server < Sinatra::Base

    before do
      content_type 'application/json'
    end

    get '/' do
      { :IanVaughan => 10 }.to_json
    end

  end
end
