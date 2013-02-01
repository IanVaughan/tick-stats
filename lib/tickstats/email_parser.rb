require 'date'

module TickStats
  class EmailParser

    class << self
      def parse text
        return '' unless text
        date = ''
        names = {}
        text.each_line do |line|
          date = parse_date(find_date(line)) if line =~ /^The following people/
          names.merge!(extract_name_hour(line)) if line =~ /^  /
        end
        { date => names }
      end

      def find_date text
        test_string = 'Tickspot for '
        # return if text.nil? || text.index(test_string) == 0
        index = text.index(test_string) + test_string.length
        text.chomp[index..-2]
      end

      def parse_date date
        DateTime.parse(date)
      end

      def extract_name_hour line
        split = line.split(':')
        { split.first.lstrip => split.last.lstrip.to_f }
      end
    end

  end
end
