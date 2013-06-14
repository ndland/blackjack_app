require 'spec_helper'

describe Api::PlayerCardsController do
  describe "#show" do
    before do
      @game = Fabricate(:game_list)
      @player_cards1 = Fabricate(:player_cards)
      @player_cards2 = Fabricate(:player_cards)
    end

    it "has status code 200 for a game that exists" do
      response.status.should equal(200)
    end

    it "renders the json for the cards" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0]['suit'].should eq(@player_cards1.suit)
    end

    it "renders more than one card for the user when a successful bet is placed" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0]['suit'].should eq(@player_cards1.suit)
      theJson[1]['suit'].should eq(@player_cards2.suit)
    end

    it "only renders the fields suit and faceValue" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0].should have_key("suit");
      theJson[0].should have_key("faceValue");

      theJson[0].should_not have_key("created_at");
      theJson[0].should_not have_key("updated_at");
    end
  end
end
