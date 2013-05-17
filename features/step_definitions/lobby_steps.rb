Given (/^I have three tables$/) do
	
		Fabricate(:table, name: "Beginner's Table", max: 50)
		Fabricate(:table, name: "Intermediate Table", min: 50, max: 100)
		Fabricate(:table, name: "High Roller Table", min: 100)

	Table.count.should == 3

end

When (/^I visit the lobby page$/) do
	visit "/"
	page.should have_title('Lobby')
end
Then (/^I should see all of my tables$/) do 
	page.should have_link("Beginner's Table")
	page.should have_content("Min: 10")
	page.should have_content("Max: 50")
	page.should have_link("Intermediate Table")
	page.should have_content("Min: 50")
	page.should have_content("Max: 100")
	page.should have_link("High Roller Table")
	page.should have_content("Min: 100")
end