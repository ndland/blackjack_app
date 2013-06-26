require 'spec_helper'
require 'mocha/setup'

describe Api::HitController do
  describe "#post" do
    before do
      @game = Fabricate(:game_list)
    end

    it "has a status code 200 for a game that exists" do
      response.status.should equal(200)
    end

    it "has a dealer object" do
      subject.dealer.should be
    end

    it "renders the game_id" do
      subject.dealer = stub('Dealer', :deal_player_card => nil, :deal_dealer_card =>nil)

      post :create, :game_id => @game.id
      response.status.should equal(200)
    end

    it "the dealer deals a new card for the player" do
      dealerMock = mock()
      dealerMock.expects(:deal_player_card).returns(true).once
      subject.dealer = dealerMock

      post :create, :game_id => @game.id
    end
  end
end
