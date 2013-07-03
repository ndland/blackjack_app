require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    before do
      @card = Fabricate (:card)
    end

    describe "the player" do

      it "should have a method deal_player_card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(42)
      end

      it "should get a card from the sleeve" do
        cardStub = stub('Card')
        cardStub.expects(:get_card).returns(@card)
        subject.card = cardStub
        subject.deal_player_card(42)
      end

      it "should save the cards to PlayerCards" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(42)
        PlayerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(41)
        PlayerCards.first.suit.should eq(@card.suit)
        PlayerCards.first.faceValue.should eq(@card.faceValue)
      end

     it "shouldn't deal another card if Player's Cards value is over 21" do
        Fabricate(:player_cards, faceValue: "K", game_id: 41)
        Fabricate(:player_cards, faceValue: "K", game_id: 41)
        Fabricate(:player_cards, faceValue: "2", game_id: 41)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 41)
        subject.deal_player_card(41)
        PlayerCards.count.should eq(3)
     end

     it "should call play if Player's Cards value is over 21" do
        Fabricate(:player_cards, faceValue: "K", game_id: 41)
        Fabricate(:player_cards, faceValue: "K", game_id: 41)
        Fabricate(:player_cards, faceValue: "2", game_id: 41)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 41)
        subject.deal_player_card(41)
        Winner.count.should eq(1)
     end
    end

    describe "the dealer" do

      it "should have a method deal_dealer_card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(42)
      end

      it "should get a card from the sleeve" do
        cardStub = stub('Card')
        cardStub.expects(:get_card).returns(@card)
        subject.card = cardStub
        subject.deal_dealer_card(42)
      end

      it "should save the cards to dealerCards" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(42)
        DealerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(41)
        DealerCards.first.suit.should eq(@card.suit)
        DealerCards.first.faceValue.should eq(@card.faceValue)
      end
    end
  end

  describe "the dealer playing" do

    before do
      @user = Fabricate(:person, credits: 100)
      @game = Fabricate(:game_list, bet_amount: 20)
      @user_card = Fabricate(:player_cards, faceValue:"A", game_id: @game.id)
      @dealer_card =Fabricate(:dealer_cards, faceValue:"3", game_id: @game.id)
    end

    it "should have a method play" do
      subject.play(@game.id)
    end

    it "should get another card if hands total is less then 17" do
      subject.play(@game.id)
      @cards  = DealerCards.find(:all, conditions:{game_id: @game.id});
      subject.faceValue_total(@cards).should_not eq(3)
    end

    it "should continue to get another card if the total is less then 17" do
      Fabricate(:dealer_cards, faceValue:"Q", game_id: @game.id)
      cardMock = mock()
      cardMock.expects(:get_card).returns(@dealer_card).twice
      subject.card = cardMock

      subject.play(@game.id)
    end

    it "should call find_winner when the total is 17 or higher" do
      subject.play(@game.id)
      Winner.count.should eq(1)
    end
  end

  describe "find_winner" do
    before do
      @user = Fabricate(:person, credits: 100)
      @game1 = Fabricate(:game_list, bet_amount: 20)
      @game = Fabricate(:game_list, table_id: 2, bet_amount: 20)
      @user_card = Fabricate(:player_cards, faceValue:"A", game_id: @game.id)
      @dealer_card =Fabricate(:dealer_cards, faceValue:"3", game_id: @game.id)
      Fabricate(:player_cards, faceValue: "K", game_id: @game1.id)
      Fabricate(:player_cards, faceValue: "7", game_id: @game1.id)
      Fabricate(:dealer_cards, faceValue: "K", game_id: @game1.id)
    end

    it "should have a method find_winner" do
      subject.find_winner(@game.id)
    end

    it "should create a new winner in the table" do
      subject.find_winner(@game.id)
      Winner.count.should eq(1)
    end

    it "should create a new winner with a game_id" do
      subject.find_winner(@game.id)
      Winner.first.game_id.should eq(@game.id)
    end

    it "player wins if players card value is 17 and dealers card value is 15" do
      Fabricate(:dealer_cards, faceValue: "5", game_id: @game1.id)
      subject.find_winner(@game1.id)
      Winner.first.outcome.should eq("Player is the Winner")
    end

    it "dealer wins if players card value is 17 and dealers card value is 19" do
      Fabricate(:dealer_cards, faceValue: "9", game_id: @game1.id)
      subject.find_winner(@game1.id)
      Winner.first.outcome.should eq("Dealer is the Winner")
    end

    it "player wins if players cards value is 17 and dealers cards are 22" do
      Fabricate(:dealer_cards, faceValue: "K", game_id: @game1.id)
      Fabricate(:dealer_cards, faceValue: "2", game_id: @game1.id)
      subject.find_winner(@game1.id)
      Winner.first.outcome.should eq("Player is the Winner")
    end

    it "returns 'No Winner' if the player and the dealer have the same score" do
      Fabricate(:dealer_cards, faceValue: "7", game_id: @game1.id)
      subject.find_winner(@game1.id)
      Winner.first.outcome.should eq("No Winner: game was a push")
    end

    it "calls pay_player when the player wins" do
      Fabricate(:dealer_cards, faceValue: "K", game_id: @game1.id)
      Fabricate(:dealer_cards, faceValue: "2", game_id: @game1.id)
      subject.find_winner(@game1.id)
      @user.reload
      @user.credits.should eq(140)
    end

    it "calls pay_player with game_id, and 1 when the game is a push" do
      Fabricate(:dealer_cards, faceValue: "7", game_id: @game1.id)
      subject.find_winner(@game1.id)
      @user.reload
      @user.credits.should eq(120)
    end
  end

  describe "checkOver21" do

    it "should return 0 if the card total is over 21" do
      subject.checkOver21(42).should eq(0)
    end

    it "should return 21 if the card total is 21" do
      subject.checkOver21(21).should eq(21)
    end

    it "should return the card total if the card total is under 21" do
      subject.checkOver21(11).should eq(11)
    end
  end

  describe "adding up the faceValue_total of the hand" do
    before do
      Fabricate(:dealer_cards, faceValue: "2", suit: "int")
      Fabricate(:dealer_cards, faceValue: "3", suit: "int")
      Fabricate(:dealer_cards, faceValue: "J")
      Fabricate(:dealer_cards, faceValue: "K")
      Fabricate(:dealer_cards, faceValue: "Q")
      Fabricate(:dealer_cards, faceValue: "A")
    end

    it "should have a method faceValue_total(cards)" do
      @cards  = DealerCards.find(:all);
      subject.faceValue_total(@cards)
    end

    it "should return the value of 2" do
      @cards  = DealerCards.find(:all, conditions:{faceValue: "2"});
      subject.faceValue_total(@cards).should eq(2)
    end

    it "should return the value of 2 cards" do
      @cards  = DealerCards.find(:all, conditions:{suit: "int"});
      subject.faceValue_total(@cards).should eq(5)
    end

    it "should return the value of a Jack" do
      @cards  = DealerCards.find(:all, conditions:{faceValue: "J"});
      subject.faceValue_total(@cards).should eq(10)
    end

    it "should return the value of a Queen" do
      @cards  = DealerCards.find(:all, conditions:{faceValue: "Q"});
      subject.faceValue_total(@cards).should eq(10)
    end

    it "should return the value of a King" do
      @cards  = DealerCards.find(:all, conditions:{faceValue: "K"});
      subject.faceValue_total(@cards).should eq(10)
    end

    it "should return the value of Ace as 11 when value is under 21" do
      @cards  = DealerCards.find(:all, conditions:{faceValue: "A"});
      subject.faceValue_total(@cards).should eq(11)
    end

    it "should return the value of Ace as 1 when value is greater than equal 11" do
      @cards  = DealerCards.find(:all);
      subject.faceValue_total(@cards).should eq(36)
    end
  end

  describe "#new_hand" do
    before do
      @card = Fabricate (:card)
    end

    it "should have a method new_hand" do
      subject.new_hand(3)
    end

    it "gets two cards for the dealer and the player" do
      subject.new_hand(3)
      DealerCards.count.should eq(2)
      PlayerCards.count.should eq(2)
    end

    it "deletes the old hand and deals the new hand to the player and dealer" do
      Fabricate(:dealer_cards, game_id: 2);
      Fabricate(:player_cards, game_id: 2);
      subject.new_hand(2)
      DealerCards.count.should eq(2)
      PlayerCards.count.should eq(2)
    end

    it "refreshes the winner after each hand" do
      Fabricate(:winner, game_id: 2)
      subject.new_hand(2)
      Winner.count.should eq(0)
    end

    it "only deletes the winner of current game" do
      Fabricate(:winner, game_id: 2)
      Fabricate(:winner, game_id: 42)
      subject.new_hand(2)
      Winner.count.should eq(1)
    end
  end

  describe "#pay_player" do
    before do
      @user = Fabricate(:person, credits: 100)
      @game = Fabricate(:game_list, bet_amount: 20)
    end

    it "has a method 'pay_player'" do
      subject.pay_player(@game.id, 1)
    end

    it "doubles a players bet in credits" do
      subject.pay_player(@game.id, 2)
      @user.reload
      @user.credits.should eq(140)
    end

    it "returns the users bet if the game is a push" do
      subject.pay_player(@game.id, 1)
      @user.reload
      @user.credits.should eq(120)
    end
  end
end
