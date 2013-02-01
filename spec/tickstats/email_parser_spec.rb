require 'spec_helper'

module TickStats
  describe EmailParser do
    let(:text) {"Hello,

The following people should be ashamed of themselves for not completing their time on Tickspot for Tuesday, 07 Aug '12:

  First Person: 0
  Second Person: 1.2

Please berate them at every possible opportunity."}

    it "should find the date" do
      text = "The following people should be ashamed of themselves for not completing their time on Tickspot for Tuesday, 07 Aug '12:"
      EmailParser.find_date(text).should == "Tuesday, 07 Aug '12"
    end

    it "should convert the date" do
      date = "Tuesday, 07 Aug '12"
      EmailParser.parse_date(date).should == "2012-08-07"
    end

    it "should extract name and whole number into a hash" do
      text = "  First Person: 1"
      EmailParser.extract_name_hour(text).should == {"First Person" => 1}
    end

    it "should extract name and floating point number into a hash" do
      text = "  First Person: 1.2"
      EmailParser.extract_name_hour(text).should == {"First Person" => 1.2}
    end

    it "should parse emails and extract names and hours into a hash" do
      EmailParser.parse(text).should == {"2012-08-07" => {'First Person' => 0, 'Second Person' => 1.2}}
    end


  end
end
