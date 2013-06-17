require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    describe "#the player" do

      it "should have a method deal_player_card" do
        subject.sleeve = stub('Sleeve', :getCard => "QS")
        subject.deal_player_card(game_id: 42)
      end

      it "should get a card from the sleeve" do
        sleeveStub = stub('Sleeve')
        sleeveStub.expects(:getCard).returns("QS")
        subject.sleeve = sleeveStub
        subject.deal_player_card(game_id: 42)
      end

      it "should save the cards to @player_cards" do
        subject.sleeve = stub('Sleeve', :getCard => "QS")
        subject.deal_player_card(game_id: 42)
        PlayerCards.count.should eq(1)
      end

      it "should have the correct value for the new card" do
        subject.sleeve = stub('Sleeve', :getCard => "QS")
        subject.deal_player_card(game_id: 41)
        PlayerCards.first.suit.should eq("S")
        PlayerCards.first.faceValue.should eq("Q")
      end
    end
  end
end
