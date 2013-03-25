require 'json'
require 'logger'
require './lib/tickstats/stats'
require './lib/tickstats/server'
require './lib/tickstats/updater'

module TickStats

  RESULTS_FILE = 'totals.yml'
  class << self

    # configure :development do
    #   $logger = Logger.new(STDOUT) # move
    # end

    def stats
      @stats ||= Stats.new(logger)
    end

    def logger
      @logger ||= Logger.new(STDOUT)
      #"./log/tick_stats.log")
    end
  end
end
