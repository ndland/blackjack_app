require 'spec_helper'

describe ApplicationHelper do
		
	describe "link_to_game" do
	  describe "when the selected game exists" do
	
      before do
        @user =  Fabricate(:person,  id: 1)
        @table =  Fabricate(:table, id: 1)
        Fabricate(:game_list, id: 1)
      end

      it "should give the correct path" do
        link = link_to_game(@user, @table)
      end
    end

    describe "when the selected game doesnt exists" do
      before do
        @user =  Fabricate(:person)
        @table =  Fabricate(:table)
      end

      it "should give the correct path" do
        link = link_to_game(@user, @table)
        link.should eq("/game/20")
      end
    end
	end
end
