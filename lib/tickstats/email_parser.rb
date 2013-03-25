module TickStats
  class EmailParser

    class << self
      def parse text
        date = parse_date(find_date(text[:subject]))
        names = {}
        text[:body].each_line do |line|
          names.merge!(extract_name_hour(line)) if line =~ /^  /
        end
        { date => names }
      end

      def find_date text
        test_string = 'Tickspot Email of Shame for '
        index = text.index(test_string) + test_string.length
        text.chomp[index..-1]
      end

      def parse_date date
        DateTime.parse(date)
      end

      def extract_name_hour line
        return {} if line == ''
        split = line.split(':')
        { split.first.lstrip => split.last.lstrip.to_f }
      end
    end

  end
end
