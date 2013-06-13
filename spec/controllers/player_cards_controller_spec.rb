require 'spec_helper'

describe Api::PlayerCardsController do
  describe "#show" do
    before do
      @game = Fabricate(:game_list);
    end

    it "has status code 200 for a game that exists" do
      response.status.should equal(200)
    end
  end
end
