Given (/^a user exists$/) do
  @user = Fabricate(:person)
end

When (/^I request the JSON for the user$/) do
  visit "/api/user/#{@user.id}"
end

Then (/^I should see the JSON for the user$/) do
  page.should have_content("#{@user.id}")
  page.should have_content("#{@user.name}")
  page.should have_content("#{@user.credits}")
  page.should have_content("#{@user.level}")
end

When (/^I request the JSON for a nonexisting user$/) do
  visit "/api/user/3"
end

Then (/^I should see 404 response code$/) do
  page.status_code.should == 404
end
