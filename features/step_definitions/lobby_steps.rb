Given (/^I have three tables$/) do
	
	3.times do
		Fabricate(:table)
	end

	Table.count.should == 3

end

When (/^I visit the lobby page$/) do
	visit "/"
	page.should have_title('Lobby')
end
Then (/^I should see all of my tables$/) do 
	page.should have_content("Beginner's Table")
	page.should have_content("Intermediate Table")
	page.should have_content("High Roller Table")
end
