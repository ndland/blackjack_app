Feature: Game Page

  Scenario: Getting back to the lobby page
    Given I am on a game page
    When I click the Lobby link
    Then I should see the lobby page
