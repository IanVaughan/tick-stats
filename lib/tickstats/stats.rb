require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Stats

    def initialize config_file = 'config/gmail.yml'
      config = YAML.load(File.read(config_file))
      @email_access = TickStats::EmailAccess.new config
      @results_file = 'totals.yml'
    end

    def totals
      load
    end

    def load
      update unless File.exists? @results_file
      YAML.load(File.open(@results_file))
    end

    def update
      data = @email_access.fetch

      result = {}
      data.each do |e|
        result.merge! EmailParser.parse(e)
      end

      # result = result.sort

      File.open(@results_file, 'w') do |file|
        file.puts result.to_yaml
      end

    end

  end
end
