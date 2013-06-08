require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Updater

    def initialize logger = nil
      @logger = logger(STDOUT)
      @email_access = TickStats::EmailAccess.new(@logger)
    end

    def update
      data = @email_access.fetch

      result = {}
      data.each do |e|
        result.merge! EmailParser.parse(e)
      end

      results.each do |date, data|
        data.each do |name, hours|
          Stat.new(:date => date, :person => name, :hours => hours)
        end
      end
    end

  end
end
