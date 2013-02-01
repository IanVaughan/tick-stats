require 'spec_helper'

module TickStats
  describe EmailParser do
    let(:text) {"Hello,

The following people should be ashamed of themselves for not completing their time on Tickspot for Tuesday, 07 Aug '12:

  First Person: 0
  Second Person: 1.2

Please berate them at every possible opportunity."}

    it "finds the date part" do
      text = "The following people should be ashamed of themselves for not completing their time on Tickspot for Tuesday, 07 Aug '12:"
      EmailParser.find_date(text).should == "Tuesday, 07 Aug '12"
    end

    it "converts the date" do
      date = "Tuesday, 07 Aug '12"
      EmailParser.parse_date(date).should == DateTime.new(2012, 8, 7)
    end

    it "finds the persons name and whole number into a hash" do
      text = "  First Person: 1"
      EmailParser.extract_name_hour(text).should == {"First Person" => 1}
    end

    it "finds the persons name and floating point number into a hash" do
      text = "  First Person: 1.2"
      EmailParser.extract_name_hour(text).should == {"First Person" => 1.2}
    end

    it "parses emails and extract names and hours into a hash" do
      EmailParser.parse(text).should == {DateTime.new(2012, 8, 7) => {'First Person' => 0, 'Second Person' => 1.2}}
    end

  end
end
