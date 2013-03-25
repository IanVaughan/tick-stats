require 'spec_helper'

module TickStats
  describe Stats do

    let(:data) do
      {
        DateTime.new(2012, 8, 8) => {'First Person' => 0, 'Second Person' => 1.2},
        DateTime.new(2012, 8, 9) => {'First Person' => 1, 'Second Person' => 1.8}
      }
    end

    subject(:stats) { Stats.new }
    before { stats.stub(:data).and_return(data) }

    its(:totals) { should == data }
    its(:sum) { should == {'First Person' => 14.0, 'Second Person' => 12.0} }
    its(:daily) { should == { DateTime.new(2012, 8, 8) => 13.8,
                              DateTime.new(2012, 8, 9) => 12.2 } }

    # its(:weekly) { should == DateTime.new(2012, 8, 9) => 13.8 }
  end
end
