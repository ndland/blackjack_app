Feature: Game Page

  Scenario: Getting back to the lobby page
    Given I am on a game page
    When I click the Lobby link
    Then I should see the lobby page

  Scenario: Making a bet
    Given I am on a game page
      And I have 101 credits
    When I make a bet of 10
    Then I should my bet on the table
      And I should have 90 credits left
