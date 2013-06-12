Given (/^I am on a game page$/) do
  @game = Fabricate(:game_list, table_id: 1)
  @table = Fabricate(:table, id: 1)
  @user = Fabricate(:person)

  visit "/game/#{@game.id}"
end

When (/^I click the Lobby link$/) do
  click_link("Lobby")
end

Then (/^I should see the lobby page$/) do
  page.should have_title("Lobby")
end

Given(/^I have (\d+) credits$/) do |arg1|
  @user.credits = arg1
end

When (/^I make a bet of (\d+)$/) do |arg1|
  find('#betInput').set arg1
end

When (/^I hit the bet button$/) do
  click_button "bet"
end

Then(/^take a screenshot$/) do
  page.save_screenshot 'screenshot.png'
  Launchy.open "#{Dir.pwd}/screenshot.png"
end
Then (/^I should have (\d+) credits left$/) do |arg1|
  sleep 10

  @user.reload
  @user.credits.should eq(arg1.to_i)
end

Then(/^I should see 2 player cards$/) do
  page.should have_content('1C 2C')
end
