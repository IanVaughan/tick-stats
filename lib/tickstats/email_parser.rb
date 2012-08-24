require 'date'

module TickStats
  class EmailParser

    def self.parse text
      return '' unless text
      date = ''
      names = {}
      text.each_line do |line|
        date = parse_date(find_date(line)) if line =~ /^The following people/
        names.merge!(extract_name_hour(line)) if line =~ /^  /
      end
      {date => names}
    end

    def self.find_date text
      test_string = 'Tickspot for '
      index = text.index(test_string) + test_string.length
      text.chomp[index..-2]
    end

    def self.parse_date date
      Date.parse(date).strftime("%Y-%m-%d")
    end

    def self.extract_name_hour line
      split = line.split(':')
      {
        split.first.lstrip => split.last.lstrip.to_f
      }
    end

  end
end
