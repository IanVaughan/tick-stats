require 'spec_helper'

# describe "TickStats" do
describe "Server" do

  it "should load" do
    get '/'

    last_response.should be_ok
    header_content(last_response).should == 'application/json'

    last_response.body.should == {:IanVaughan => 10}.to_json
  end
end

def header_content response
  response.headers['Content-Type'].split(';')[0].strip.downcase
end

# post '/', params = {:p1 => 'test'}
