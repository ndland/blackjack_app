Feature: Lobby page

	Scenario: Visiting the lobby page then I should see all of my tables
		Given I have three tables
			And I have a user
		When I visit the lobby page
		Then I should see all of my tables

    Scenario: Visiting the Lobby page I should see my user widget
    	Given I have a user
    	When I visit the lobby page
    	Then I should see my user widget