Feature: User Api

  Scenario: Making a request for an existing user
    Given a user exists
    When I request the JSON for the user
    Then I should see the JSON for the user

  @allow-rescue
  Scenario: Making a request for a nonexisting user
    When I request the JSON for a nonexisting user
    Then I should see 404 response code

