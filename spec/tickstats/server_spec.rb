require 'spec_helper'

module TickStats
  describe Server do

    it "should load" do
      pending "fuck the server, fix everything else first"
      get '/test'

      last_response.should be_ok
      header_content(last_response).should == 'application/json'

      last_response.body.should == {:abc => 10}.to_json
    end
  end

end

def header_content response
  response.headers['Content-Type'].split(';')[0].strip.downcase
end
