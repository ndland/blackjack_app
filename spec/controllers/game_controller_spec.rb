require 'spec_helper'

describe GameController do

  describe "creating a new game" do
   before do
    @user = Fabricate(:person)
    @table = Fabricate(:table)
   end

    it "should create a new game" do

    visit '/'
    click_link @table.name

    @game = GameList.find(:first, conditions: { user_id: @user.id, table_id: @table.id })
    @game.should_not eq nil
    end
  end
end
