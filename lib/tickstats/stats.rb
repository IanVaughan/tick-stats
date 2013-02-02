require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Stats

    HOURS = 7.5

    def initialize logger = nil, config_file = 'config/gmail.yml'
      @logger = logger
      config = YAML.load(File.read(config_file))
      @email_access = TickStats::EmailAccess.new(config, @logger)
    end

    def totals
      @logger.debug "Stats::totals" if @logger
      load
    end

    def sum
      sums = Hash.new { |hash, key| hash[key] = 0 }
      data = load
      data.each do |date, data|
        data.each do |name, hours|
          sums[name] += HOURS - hours
        end
      end
      sums
    end

    def daily
      sums = {}
      data = load
      data.each do |date, data|
        daily = 0
        data.each do |name, hours|
          daily += HOURS - hours
        end
        sums[date] = daily
      end
      sums
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

      File.open(RESULTS_FILE, 'w') do |file|
        file.puts result.to_yaml
      end
    end

  end
end
