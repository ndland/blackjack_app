require 'spec_helper'
require 'mocha/setup'

describe Api::BetController do
  describe "#post" do
    before do
      @user = Fabricate(:person, credits:100)
      @game = Fabricate(:game_list, user_id: @user.id)
    end

    it "has status code 200 for a user that exists" do
      response.status.should equal(200)
    end

    it "renders the game_id" do
      subject.dealer = stub('Dealer', :deal_player_card => nil, :deal_dealer_card =>nil)

      post :create, :game_id => @game.id, :bet => 20
      @user.reload
      expect(@user.credits).to eq(80)
    end

    it "has a dealer object" do
      subject.dealer.should be
    end

    it "the dealer deals 2 new cards for the player and the dealer" do
      dealerMock = mock()
      dealerMock.expects(:deal_player_card).returns(true).twice
      dealerMock.expects(:deal_dealer_card).returns(true).twice
      subject.dealer = dealerMock

      post :create, :game_id => @game.id, :bet => 20
    end
  end
end
