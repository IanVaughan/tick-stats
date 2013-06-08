require 'json'
require 'logger'
require './lib/tickstats/stats'
require './lib/tickstats/server'
require './lib/tickstats/updater'

module TickStats

  class << self

    def stats
      @stats ||= Stats.new(logger)
    end

    def logger(where="./log/tick_stats.log")
      @logger ||= Logger.new(where)
    end
  end
end
