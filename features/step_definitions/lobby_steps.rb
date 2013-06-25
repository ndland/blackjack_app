Given /^I have three tables$/ do Fabricate(:table, name: "Beginner's Table", max: 50)
  Fabricate(:table, name: "Intermediate Table", min: 50, max: 100)
  Fabricate(:table, name: "High Roller Table", min: 100)

  Table.count.should == 3

end

When /^I visit the lobby page$/ do
  visit "/"
  page.should have_title('Lobby')
end

Then /^I should see all of my tables$/ do
  page.should have_link("Beginner's")
  page.should have_content("Min: 10")
  page.should have_content("Max: 50")
  page.should have_link("Intermediate")
  page.should have_content("Min: 50")
  page.should have_content("Max: 100")
  page.should have_link("High Roller")
  page.should have_content("Min: 100")
end

Given /^I have a user$/ do
  # Fabricate(:person, id: 1)
  Fabricate(:person)
end

# Then /^I should see my user widget$/ do
#   page.should have_content("Bob Smith")
#   page.should have_content("Credits: 100")
#   page.should have_content("level: 1")
# end

When /^I select the Beginner's table$/ do
  visit "/"
  click_link("Beginner's Table")
end

Then /^The Beginners game page should be shown$/ do
  page.should have_content("Beginner's Table")
end
