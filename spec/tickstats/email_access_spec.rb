require 'spec_helper'
require './lib/tickstats/email_access'

module TickStats
  describe EmailAccess do

    # let(:config) { YAML.load( File.read('config/gmail.yml') ) }
    # let(:ea) { EmailAccess.new config }

    # it "should get emails" do
    #   text = '"Hello,\n\nThe following people should be ashamed of themselves for not completing their time on Tickspot for Wednesday, 25 Jul \'12:\n\n  Dush Patel: 0\n  Lambert Egbe: 7.0\n  Kanthan Siva: 0\n\nPlease berate them at every possible opportunity."'

    #   config = YAML.load( File.read('config/gmail.yml') )
    #   email = TickStats::EmailAccess.new config
    #   email.fetch.should == []

    #   # ea.stub(:with_gmail).expects('user', 'pass').and_returns mock_gmail

    #   # ea.fetch.should == text

    # end
  end

end
