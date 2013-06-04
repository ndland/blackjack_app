require 'spec_helper'

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
      post :create, :game_id => @game.id, :bet => 20
      @user.reload
      expect(@user.credits).to eq(80)
    end
  end
end
