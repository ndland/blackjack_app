require 'spec_helper'

describe Api::WinnerController do
  describe "#show" do
    before do
      @game = Fabricate(:game_list)
      @winner = Fabricate(:winner, game_id: @game.id)
    end

    it "has status code 200 for a game that exists" do
      response.status.should equal(200)
    end

    it "has the correct route /api/game/id/winner" do
      get :index, game_id: @game.id
    end

    it "renders the winner of the game" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson['outcome'].should eq(@winner.outcome)
    end
  end
end
