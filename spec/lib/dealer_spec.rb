require 'spec_helper'
require 'mocha/setup'

describe Dealer do
  describe "#dealing a card to" do

    describe "#the player" do

    # it "should have a method deal_player_card" do
    #     subject.card = stub('Card', :get_card => '#<Card id: 41, suit: "S", faceValue: "Q", cardUsed: true, order: 1, created_at: "2013-06-24 13:53:46", updated_at: "2013-06-24 13:53:47">')
    #     subject.deal_player_card(game_id: 42)
    #   end

    #   it "should get a card from the sleeve" do
    #     cardStub = stub('Card')
    #     cardStub.expects(:get_card).returns('#<Card id: 41, suit: "S", faceValue: "Q", cardUsed: true, order: 1, created_at: "2013-06-24 13:53:46", updated_at: "2013-06-24 13:53:47">')
    #     subject.card = cardStub
    #     subject.deal_player_card(game_id: 42)
    #   end

    #   it "should save the cards to @player_cards" do
    #     subject.card = stub('Card', :get_card => '#<Card id: 41, suit: "S", faceValue: "Q", cardUsed: true, order: 1, created_at: "2013-06-24 13:53:46", updated_at: "2013-06-24 13:53:47">')
    #     subject.deal_player_card(game_id: 42)
    #     PlayerCards.count.should eq(1)
    #   end

      it "should have the correct value for the new card" do
        subject.card = stub('Card', get_card: { suit: "S", faceValue: "Q" })
        subject.deal_player_card(game_id: 41)
        PlayerCards.first.suit.should eq("S")
        PlayerCards.first.faceValue.should eq("Q")
      end
    end
  end
end
