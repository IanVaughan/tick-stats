require 'spec_helper'
require './lib/tickstats/email_parser'

module TickStats
  describe EmailParser do
    context "with people not filling out tick" do
      let(:email) do {
        subject: "Tickspot Email of Shame for Tuesday, 07 Aug '12",
        body: "Hello,\n\nThe following people should be ashamed of themselves for not completing their time on Tickspot for Tuesday, 07 Aug \'12:\n\n  First Person: 0\n  Second Person: 1.2\n\nPlease berate them at every possible opportunity."
      }
      end

      it "finds the date part" do
        EmailParser.find_date(email[:subject]).should == "Tuesday, 07 Aug '12"
      end

      it "converts the date" do
        date = "Tuesday, 07 Aug '12"
        EmailParser.parse_date(date).should == DateTime.new(2012, 8, 7)
      end

      it "finds the persons name and whole number into a hash" do
        text = "  First Person: 1"
        EmailParser.extract_name_hour(text).should == {nake: "First Person", hours: 1}
      end

      it "finds the persons name and floating point number into a hash" do
        text = "  First Person: 1.2"
        EmailParser.extract_name_hour(text).should == {name: "First Person", hours: 1.2}
      end

      it "parses emails and extract names and hours into a hash" do
        EmailParser.parse(email).should == {
          date: DateTime.new(2012, 8, 7) => [
            {name: 'First Person', hours: 0},
            {name: 'Second Person', name: 1.2}
            ]
          }
      end
    end

    context "with everyone filling in their tick" do
      let(:email) do {
        subject: "Tickspot Email of Shame for Tuesday, 07 Aug '12",
        body: "Hello,\n\nYou'll be pleased to hear that yesterday *everyone* completed their time on Tickspot!\n\nLong may the trend continue!"
      }
      end

      it "finds the persons name and whole number into a hash" do
        EmailParser.extract_name_hour("").should == {}
      end

      it "parses emails and extract names and hours into a hash" do
        EmailParser.parse(email).should == {DateTime.new(2012, 8, 7) => {}}
      end
    end

  end
end
