module TickStats
  class Stats

    HOURS = 7.5

    def initialize logger = nil
      @logger = logger
    end

    def totals
      data
    end

    def sum
      sums = Hash.new { |hash, key| hash[key] = 0 }
      data.each do |date, data|
        data.each do |name, hours|
          sums[name] += HOURS - hours
        end
      end
      sums
    end

    def daily
      sums = {}
      data.each do |date, data|
        daily = 0
        data.each do |name, hours|
          daily += HOURS - hours
        end
        sums[date] = daily
      end
      sums
    end

    private

    def data
      @data ||= YAML.load(File.open(TickStats::RESULTS_FILE)) if File.exists?(TickStats::RESULTS_FILE)
    end
  end
end
