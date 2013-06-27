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

    # it "should have a method play" do
    #   subject.play(42)
    # end

    describe "adding up the faceValue_total of the hand" do

      # it "should have a method faceValue_total(cards)" do
      #   @cards  = DealerCards.find(:all, conditions:{game_id: 42});
      #   subject.faceValue_total(@cards)
      # end

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

      # it "uses the cards from PlayerCards to determine the total value" do
      #   @cards  = DealerCards.find(:all, conditions:{game_id: 42});
      #   subject.faceValue_total(@cards).should eq(15)
      # end
    end
  end
end
