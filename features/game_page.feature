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
    Then I should have 90 credits left

    @javascript
  Scenario: Viewing the cards
    Given I am on a game page
    And I have 100 credits
    When I make a bet of 10
    And I hit the bet button
    Then I should see 2 player cards and 2 dealer cards

    @javascript
  Scenario: Player Hitting
    Given I am on a game page
    And I have already placed a bet
    When I hit the Hit button
    Then I should see 3 player cards and 2 dealer cards

    @javascript
  Scenario: Player Standing
    Given I am on a game page
    And I have already placed a bet
    When I hit the Stand button
    Then I should see the outcome of the hand

    @javascript
  Scenario: Cards are removed after each hand
    Given I am on a game page
    And I have already played a hand
    When I hit the bet button
    Then I should have a new hand

    @javascript
  Scenario: Winners receive a 2 to 1 payout on the bet
    Given I am on a game page
    When I have won a hand
    Then I should receive a 2 to 1 payout of my bet

    @WIP
    @javascript
  Scenario: Player is unable to hit if the face value total is >= 21
    Given I am on a game page
    When I have a hand of over 21
    And I hit the Hit button
    Then I should not be given another card
