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
  Capybara.default_wait_time = 5;
  puts page.body
  # page.should have_selector(:xpath, "//input[@type='#text']")
  find('label', :text => 'betInput')
  # find_by_id('betInput')
  # fill_in '#betInput', with: arg1
  click_button "bet"
end

