require 'spec_helper'

describe Api::DealerCardsController do
  describe "#index" do
    before do
      @game = Fabricate(:game_list)
      @dealer_cards1 = Fabricate(:dealer_cards, game_id: @game.id)
      @dealer_cards2 = Fabricate(:dealer_cards, game_id: @game.id)
    end

    it "has status code 200 for a game that exists" do
      response.status.should equal(200)
    end

    it "renders the json for the cards" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0]['suit'].should eq(@dealer_cards1.suit)
    end

    it "renders more than one card for the dealer when a successful bet is placed" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0]['suit'].should eq(@dealer_cards1.suit)
      theJson[1]['suit'].should eq(@dealer_cards2.suit)
    end

    it "only renders the fields suit and faceValue" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body)

      theJson[0].should have_key("suit");
      theJson[0].should have_key("faceValue");

      theJson[0].should_not have_key("created_at");
      theJson[0].should_not have_key("updated_at");
    end

      it "only renders the cards that are for that certain game" do
        @dealer_cards = Fabricate(:dealer_cards)
        get :index, game_id: @game.id
        theJson = JSON.parse(response.body)
        theJson[2].should_not be
        theJson[0].should be
      end
  end
end
