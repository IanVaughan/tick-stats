require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Stats

    RESULTS_FILE = 'totals.yml'

    def initialize logger = nil, config_file = 'config/gmail.yml'
      @logger = logger
      config = YAML.load(File.read(config_file))
      @email_access = TickStats::EmailAccess.new(config, @logger)
    end

    def totals
      @logger.debug "Stats::totals" if @logger
      load
    end

    def load reload = false
      @logger.debug "Stats::load->reload:#{reload}"
      update unless reload || File.exists?(RESULTS_FILE)
      YAML.load(File.open(RESULTS_FILE))
    end

    def update
      @logger.debug "Stats::load->update"
      data = @email_access.fetch

      result = {}
      data.each do |e|
        result.merge! EmailParser.parse(e)
      end

      File.open(@results_file, 'w') do |file|
        file.puts result.to_yaml
      end
    end

  end
end
