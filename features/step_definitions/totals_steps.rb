Given /^I have opened "([^\"]*)"$/ do |url|
  visit url
end

Then /^I should see a JSON String with "([^\"]*)"$/ do |data| #klass
  response.body.should == {:IanVaughan => 10}.to_json
end
