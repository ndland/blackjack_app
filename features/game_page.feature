Feature: Game Page

  Scenario: Getting back to the lobby page
    Given I am on a game page
    When I click the Lobby link
    Then I should see the lobby page

    @javascript
  Scenario: Making a bet
    Given I am on a game page
      And I have 100 credits
    When I make a bet of 10
      And I hit the bet button
      And I should have 90 credits left
    Then take a screenshot

    @WIP
    @javascript
  Scenario: Viewing a card
    Given I am on a game page
      And I have 100 credits
    When I make a bet of 10
      And I hit the bet button
    Then I should see 2 player cards
