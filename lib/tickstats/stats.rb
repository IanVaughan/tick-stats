module TickStats
  class Stats

    HOURS = 7.5

    def initialize logger = nil
      @logger = logger(STDOUT)
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
  end
end
