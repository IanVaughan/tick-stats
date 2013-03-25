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

    def logger
      @logger ||= Logger.new(STDOUT)
    end
  end
end
