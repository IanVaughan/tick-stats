Feature: Get totals
  Finds the totals for all users

  Scenario: Shows main page
    Given I have opened "http://localhost:4567"
    Then The response header should be "application/json"
    And It should contain "{:IanVaughan => 10}"
