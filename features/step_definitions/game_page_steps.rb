Given (/^Beginner's table was selected on lobby page$/) do
	visit "/"
	click_button("Beginner's Table")
end

When (/^I visit the game page$/) do
	page.should have_title("Beginner's Table")	
end

# Then (/^The Beginners game page should be shown$/) do
# end