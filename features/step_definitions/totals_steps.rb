Given /^I have opened "([^\"]*)"$/ do |url|
  visit url
end

Then /^The response header should be "(.*?)"$/ do |type|
  response.headers['Content-Type'].split(';')[0].strip.downcase == type
end

Then /^It should contain "(.*?)"$/ do |data|
  response.body.should == eval(data).to_json
end
