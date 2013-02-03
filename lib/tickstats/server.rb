require "sinatra/base"

module TickStats
  class Server < Sinatra::Base

    before do
      content_type :json
    end

    get '/' do
    end

    get '/totals' do
      TickStats::stats.totals.to_json
    end

    get '/daily' do
      TickStats::stats.daily.to_json
    end

    get '/sum' do
      TickStats::stats.sum.to_json
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
