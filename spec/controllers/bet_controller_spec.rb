require 'spec_helper'

describe Api::BetController do
  describe "#show" do
    before do
      @user = Fabricate(:person)
      @game = Fabricate(:game_list, user_id: @user.id)
    end

    it "has status code 200 for a user that exists" do
      get :show, id: @user.id

      response.status.should equal(200)
    end
  end
end
