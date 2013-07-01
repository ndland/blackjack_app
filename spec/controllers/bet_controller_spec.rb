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

    it "has a dealer object" do
      subject.dealer.should be
    end

    it "tells the dealer to create a new game" do

      dealerMock = mock()
      dealerMock.expects(:new_hand).with(@game.id).returns(true).once
      subject.dealer = dealerMock

      post :create, :game_id => @game.id, :bet => 20
    end
  end
end
