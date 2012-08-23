require 'yaml'
# require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Stats

    def initialize

    end

    def totals
      load
    end

    def load
      YAML.load(File.open('totals.yml'))
    end

    def update
      config = YAML.load( File.read('config/gmail.yml') )
      t = TickStats::EmailAccess.new config
      d = t.update

      result = []
      d.each do |e|
        result << EmailParser.parse(e)
      end

      puts result

      File.open('totals.yml','w') do |file|
        file.puts result.to_yaml
      end

    end

  end
end
