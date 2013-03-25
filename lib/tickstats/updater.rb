require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Updater

    def initialize logger = nil
      @logger = logger
      @email_access = TickStats::EmailAccess.new(@logger)
    end

    def update
      @logger.debug "Updater::update" if @logger
      data = @email_access.fetch

      result = {}
      data.each do |e|
        result.merge! EmailParser.parse(e)
      end

      #DB
      # File.open(RESULTS_FILE, 'w') do |file|
        # file.puts result.to_yaml
      # end
    end

  end
end
