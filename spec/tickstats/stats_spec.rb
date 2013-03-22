require 'spec_helper'

module TickStats
  describe Stats do

    let(:data) do
      {
        DateTime.new(2012, 8, 8) => {'First Person' => 0, 'Second Person' => 1.2},
        DateTime.new(2012, 8, 9) => {'First Person' => 1, 'Second Person' => 1.8}
      }
    end

    let(:stats) { Stats.new }
    before { stats.stub(:data).and_return(data) }

    it "returns all the current data" do
      stats.totals.should == data
    end

    it "gets the sum all names and hours" do
      stats.sum.should == {'First Person' => 14.0, 'Second Person' => 12.0}
    end

    it "returns daily totals" do
      stats.daily.should == { DateTime.new(2012, 8, 8) => 13.8,
                               DateTime.new(2012, 8, 9) => 12.2 }
    end

    it "returns weekly totals" do
    end

  end
end
