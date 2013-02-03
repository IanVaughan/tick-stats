require "sinatra/base"

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
      stats.totals.to_json
    end

    get '/daily' do
      stats.daily.to_json
    end

    get '/sum' do
      stats.sum.to_json
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
