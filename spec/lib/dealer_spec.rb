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
end
