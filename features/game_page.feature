Feature: Game Page

	Scenario: Selecting Beginners Table will bring me to the beginners game page
		Given I have three tables
			And Beginner's table was selected on lobby page
		When I visit the game page
		Then The Beginners game page should be shown