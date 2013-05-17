Feature: Lobby page

	Scenario: Visiting the lobby page then I should see all of my tables
		Given I have three tables
		When I visit the lobby page
		Then I should see all of my tables
