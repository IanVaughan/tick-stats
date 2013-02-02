require 'yaml'
require './lib/tickstats/email_access'
require './lib/tickstats/email_parser'

module TickStats
  class Updater

    def initialize logger = nil, config_file = 'config/gmail.yml'
      @logger = logger
      config = YAML.load(File.read(config_file))
      @email_access = TickStats::EmailAccess.new(config, @logger)

      update # every day
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
