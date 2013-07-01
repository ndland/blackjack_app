require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    before do
      @card = Fabricate (:card)
    end

    describe "#the player" do

      it "should have a method deal_player_card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(game_id: 42)
      end

      it "should get a card from the sleeve" do
        cardStub = stub('Card')
        cardStub.expects(:get_card).returns(@card)
        subject.card = cardStub
        subject.deal_player_card(game_id: 42)
      end

      it "should save the cards to PlayerCards" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(game_id: 42)
        PlayerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_player_card(game_id: 41)
        PlayerCards.first.suit.should eq(@card.suit)
        PlayerCards.first.faceValue.should eq(@card.faceValue)
      end
    end

    describe "the dealer" do

      it "should have a method deal_dealer_card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(game_id: 42)
      end

      it "should get a card from the sleeve" do
        cardStub = stub('Card')
        cardStub.expects(:get_card).returns(@card)
        subject.card = cardStub
        subject.deal_dealer_card(game_id: 42)
      end

      it "should save the cards to dealerCards" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(game_id: 42)
        DealerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.card = stub('Card', :get_card => @card)
        subject.deal_dealer_card(game_id: 41)
        DealerCards.first.suit.should eq(@card.suit)
        DealerCards.first.faceValue.should eq(@card.faceValue)
      end
    end
  end

  describe "the dealer playing" do

    before do
      @card = Fabricate(:dealer_cards, faceValue:"A", game_id: 42)
      @card1 = Fabricate(:dealer_cards, faceValue:"2", suit: "int", game_id: 42)
      @card2 = Fabricate(:dealer_cards, faceValue:"3", suit: "int", game_id: 42)
      @card3 = Fabricate(:dealer_cards, faceValue:"J", game_id: 42)
      @card4 = Fabricate(:dealer_cards, faceValue:"Q", game_id: 42)
      @card5 = Fabricate(:dealer_cards, faceValue:"K", game_id: 42)
    end

    it "should have a method play" do
      subject.play(42)
    end

    it "should get another card if hands total is less then 17" do
      @card6 = Fabricate(:dealer_cards, faceValue:"K", game_id: 4)
      @card7 = Fabricate(:dealer_cards, faceValue:"5", game_id: 4)

      subject.play(4)
      @cards  = DealerCards.find(:all, conditions:{game_id: 4});
      subject.faceValue_total(@cards).should_not eq(15)
    end

    it "should continue to get another card if the total is less then 17" do
      @card6 = Fabricate(:dealer_cards, faceValue:"Q", game_id: 4)
      @card7 = Fabricate(:dealer_cards, faceValue:"3", game_id: 4)
      cardMock = mock()
      cardMock.expects(:get_card).returns(@card1).twice
      subject.card = cardMock

      subject.play(4)
    end
    describe "find_winner" do
      it "should have a method find_winner" do
        @card6 = Fabricate(:player_cards, faceValue:"Q", game_id: 42)
        @card7 = Fabricate(:player_cards, faceValue:"3", game_id: 42)
        subject.find_winner(42)
      end

      it "should create a new winner in the table" do
        @card6 = Fabricate(:player_cards, faceValue:"Q", game_id: 42)
        @card7 = Fabricate(:player_cards, faceValue:"3", game_id: 42)
        subject.find_winner(42)
        Winner.count.should eq(1)
      end

      it "should create a new winner with a game_id" do
        @card6 = Fabricate(:player_cards, faceValue:"Q", game_id: 42)
        @card7 = Fabricate(:player_cards, faceValue:"3", game_id: 42)
        subject.find_winner(42)
        Winner.first.game_id.should eq(42)
      end

      it "should creae a new winner in the table with the correct game_id" do
        @card6 = Fabricate(:player_cards, faceValue:"Q", game_id: 2)
        Fabricate(:player_cards, faceValue:"Q", game_id: 2)
        @card7 = Fabricate(:dealer_cards, faceValue:"3", game_id: 2)
        Fabricate(:dealer_cards, faceValue:"3", game_id: 2)
        subject.find_winner(2)
        Winner.first.game_id.should eq(2)
      end

      it "player wins if players card value is 17 and dealers card value is 15" do
        Fabricate(:player_cards, faceValue: "K", game_id: 7)
        Fabricate(:player_cards, faceValue: "7", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "5", game_id: 7)
        subject.find_winner(7)
        Winner.first.outcome.should eq("Player")
      end

      it "dealer wins if players card value is 17 and dealers card value is 19" do
        Fabricate(:player_cards, faceValue: "K", game_id: 7)
        Fabricate(:player_cards, faceValue: "7", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "9", game_id: 7)
        subject.find_winner(7)
        Winner.first.outcome.should eq("Dealer")
      end

      it "player wins if players cards value is 17 and dealers cards are 22" do
        Fabricate(:player_cards, faceValue: "K", game_id: 7)
        Fabricate(:player_cards, faceValue: "7", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "2", game_id: 7)
        subject.find_winner(7)
        Winner.first.outcome.should eq("Player")
      end

      it "returns 'No Winner' if the player and the dealer have the same score" do
        Fabricate(:player_cards, faceValue: "K", game_id: 7)
        Fabricate(:player_cards, faceValue: "7", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "K", game_id: 7)
        Fabricate(:dealer_cards, faceValue: "7", game_id: 7)
        subject.find_winner(7)
        Winner.first.outcome.should eq("No Winner: game was a push")
      end

      describe "over21?" do
        it "should return 0 if the card total is over 21" do
          subject.over21?(42).should eq(0)
        end

        it "should return 21 if the card total is 21" do
          subject.over21?(21).should eq(21)
        end

        it "should return the card total if the card total is under 21" do
          subject.over21?(11).should eq(11)
        end
      end
    end

    describe "adding up the faceValue_total of the hand" do
      it "should have a method faceValue_total(cards)" do
        @cards  = DealerCards.find(:all, conditions:{game_id: 42});
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
        @cards  = DealerCards.find(:all, conditions:{game_id: 42});
        subject.faceValue_total(@cards).should eq(36)
      end
    end
  end
end
