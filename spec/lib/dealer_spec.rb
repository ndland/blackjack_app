require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    describe "#the player" do

      it "should have a method deal_player_card" do
        subject.deck = stub('Deck', :get => "QS")
        subject.deal_player_card
      end

      it "should get a card from the sleeve" do
        deckStub = stub('Deck')
        deckStub.expects(:get).returns("QS")
        subject.deck = deckStub
        subject.deal_player_card
      end

      it "should save the cards to @player_cards" do
        subject.deck = stub('Deck', :get => "QS")
        subject.deal_player_card
        PlayerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.deck = stub('Deck', :get => "QS")
        subject.deal_player_card
        PlayerCards.first.suit.should eq("S")
        PlayerCards.first.faceValue.should eq("Q")
      end
    end
  end
end
