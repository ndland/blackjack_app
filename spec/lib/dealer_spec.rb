require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    describe "#the player" do

      it "should have a method deal_player_card" do
        subject.deck = stub('Deck', :get => nil)
        subject.deal_player_card
      end

      it "should get a card from the sleeve" do
        deckMock = mock()
        deckMock.expects(:get).returns(true)
        subject.deck = deckMock
        subject.deal_player_card
      end
    end
  end
end
