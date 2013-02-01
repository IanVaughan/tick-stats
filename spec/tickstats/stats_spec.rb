require 'spec_helper'

module TickStats
  describe Stats do

    let(:data) {
      {
        DateTime.new(2012, 8, 8) => {'First Person' => 0, 'Second Person' => 1.2},
        DateTime.new(2012, 8, 8) => {'First Person' => 1, 'Second Person' => 1.8}
      }
    }

    # let(:stats) { Stats.new }
    before do
      # YAML.stub(:load).and_return(data)
      Stats.any_instance.stub(:load).and_return(data)
      @stats = Stats.new
    end

    it "should return all the current data" do
      @stats.totals.should == data
    end

    # it "should get the sum all names and hours" do
    #   stats.stub(:load).and_returns(data)
    #   Stats.sum.should = {'First Name' => 1, 'Second Name' => 3.0}
    # end

    # it "should load a saved file of data" do
    #   data.to_json
    #   stats.load
    # end

  end
end

# it "should find emails with subject 'Tickspot Email of Shame'" do
#   pending 'moving into correct email type spec'
# end
