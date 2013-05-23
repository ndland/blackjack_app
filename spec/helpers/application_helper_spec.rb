require 'spec_helper'

describe ApplicationHelper do

  describe "link_to_game" do
    # we want something like <a href="/game/new">My Table</a>
    describe "when the selected game exists" do

      before do
        @user =  Fabricate(:person)
        @table =  Fabricate(:table, :name => "My Other Table")

        @game = Fabricate(:game_list, :table_id => @table.id, :user_id => @user.id)
      end

      it "should give the correct path" do
        link = link_to_game(@user, @table)
        link.should include("/game/#{@game.id}")
      end

      it "should have the table name" do
        link = link_to_game(@user, @table)
        link.should include("My Other Table")
      end
    end

    describe "when the selected game doesnt exists" do
      before do
        @user =  Fabricate(:person)
        @table =  Fabricate(:table, name: "My Table")
      end

      it "should give a path to a new game" do
        link = link_to_game(@user, @table)
        link.should include("/game/new")
      end

      it "should have the table name" do
        link = link_to_game(@user, @table)
        link.should include("My Table")
      end

      it "should have the table.id" do
        link = link_to_game(@user, @table)
        link.should include("/new?table=#{@table.id}")
      end
      end
  end
end
