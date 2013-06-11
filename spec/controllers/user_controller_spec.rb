require 'spec_helper'

describe Api::UserController do
  describe "#show" do
    before do
      @user = Fabricate(:person)
    end

    it "has status code 200 for a user that exists" do
      get :show, id: @user.id

      response.status.should equal(200)
    end

    it "renders the json for our user" do
      get :show, id: @user.id

      theJson = JSON.parse(response.body)
      theJson["id"].should equal(@user.id)
    end

    it "only renders the fields id, credits, level, name" do
      get :show, id: @user.id

      theJson = JSON.parse(response.body)

      theJson.should have_key("id")
      theJson.should have_key("credits")
      theJson.should have_key("level")
      theJson.should have_key("name")

      theJson.should_not have_key("created_at")
      theJson.should_not have_key("updated_at")
    end
  end
end
