Feature: Get totals
  Finds the totals for all users

  Scenario: Shows main page
    Given I have opened "http://localhost:4567"
    Then I should see a JSON String with "{IanVaughan: 10}"
