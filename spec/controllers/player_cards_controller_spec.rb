require 'spec_helper'

describe Api::PlayerCardsController do
  describe "#show" do
    before do
      @game = Fabricate(:game_list);
    end

    it "has status code 200 for a game that exists" do
      response.status.should equal(200)
    end

    it "renders the json for the cards" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body);
      theJson[1]['suit'].should eq('b');
    end

    it "renders more than one card for the user when a successful bet is placed" do
      get :index, game_id: @game.id
      theJson = JSON.parse(response.body);
      theJson[0]['suit'].should eq('a');
      theJson[1]['suit'].should eq('b');
      print theJson[1]['suit']
      print theJson[1]['faceValue']
    end
  end
end
