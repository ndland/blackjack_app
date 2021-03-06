Given (/^I am on a game page$/) do
  @game = Fabricate(:game_list, table_id: 1)
  @table = Fabricate(:table, id: 1)
  @user = Fabricate(:person)
  @card1 = Fabricate(:card, suit: "suit1", faceValue: "faceValue1")
  @card2 = Fabricate(:card, suit: "suit2", faceValue: "faceValue2")
  @card3 = Fabricate(:card, suit: "suit3", faceValue: "faceValue3")
  @card4 = Fabricate(:card, suit: "suit3", faceValue: "faceValue4")

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
  find('#betInput').set(arg1)
end

When (/^I hit the bet button$/) do
  click_button "Bet"
end

Then(/^take a screenshot$/) do
  page.save_screenshot 'screenshot.png'
  Launchy.open "#{Dir.pwd}/screenshot.png"
end


Then (/^I should have (\d+) credits left$/) do |arg1|
  sleep 3

  @user.reload
  @user.credits.should eq(arg1.to_i)
end

Then(/^I should see 2 player cards and 2 dealer cards$/) do

  step "wait 2"
  PlayerCards.count.should eq(2)
  page.should have_content(@card1.suit)
  page.should have_content(@card1.faceValue)
  page.should have_content(@card2.suit)
  page.should have_content(@card2.faceValue)
  page.should have_content(@card3.suit)
  page.should have_content(@card3.faceValue)
  page.should have_content(@card4.suit)
  page.should have_content(@card4.faceValue)
end

Given (/^I have already placed a bet$/) do
  step "I have 100 credits"
  step "I make a bet of 10"
  step "I hit the bet button"
  sleep 1
  @card5 = Fabricate(:card)
end

When (/^I hit the Hit button$/) do
  click_button "Hit"
end

Then (/^I should see 3 player cards and 2 dealer cards$/) do
  page.should have_content(@card5.suit)
end

When (/^I hit the Stand button$/) do
  click_button "Stand"
end

Then (/^I should see the outcome of the hand$/) do
  step "wait 2"
  page.should have_content("Winner")
end

And (/^I have already played a hand$/) do
  step "I have already placed a bet"
  step "I hit the Stand button"
  step "I should see the outcome of the hand"
  step "I make a bet of 10"
end

Then (/^I should have a new hand$/) do
  step "wait 2"
  PlayerCards.count.should eq(2)
  page.should_not have_content(@card1.suit)
  page.should_not have_content(@card1.faceValue)
  page.should_not have_content(@card2.suit)
end

Then(/^wait (\d+)$/) do |arg1|
  passed = false
  x = 0

  until passed do
    if PlayerCards.count == arg1.to_i
      passed = true
    elsif x == 10
      p "timeout"
      passed = true
    else
      sleep 1
    end
    x += 1
  end
end

When (/^I have won a hand$/) do
  Card.destroy_all()
  Fabricate(:card, faceValue: "K")
  Fabricate(:card, faceValue: "K")
  Fabricate(:card, faceValue: "2")
  Fabricate(:card, faceValue: "A")
  step "I make a bet of 20"
  step "I hit the bet button"
  step "wait 2"
  step "I hit the Stand button"
end

Then (/^I should receive a 2 to 1 payout of my bet$/) do
  sleep 2
  @user.reload
  @user.credits.should eq(120)
end

When (/^I have a hand of over 21$/) do
  Card.destroy_all()
  Fabricate(:card, faceValue: "K")
  Fabricate(:card, faceValue: "K")
  Fabricate(:card, faceValue: "2")
  Fabricate(:card, faceValue: "K")
  Fabricate(:card, faceValue: "2")
  step "I make a bet of 20"
  step "I hit the bet button"
  step "wait 2"
  step "I hit the Hit button"
  step "wait 3"
end

Then (/^I should not be given another card$/) do
  sleep 2
  PlayerCards.count.should eq(3)
end

