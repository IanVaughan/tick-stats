module TickStats
  class Stats

    HOURS = 7.5
    RESULTS_FILE = 'totals.yml'

    def initialize logger = nil
      @logger = logger
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
      update unless reload || File.exists?(RESULTS_FILE)
      YAML.load(File.open(RESULTS_FILE))
    end

  end
end
