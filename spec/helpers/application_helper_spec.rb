require 'spec_helper'

describe ApplicationHelper do
		
	describe "link_to_game" do
	 
    before do
    @user =  Fabricate(:person)
		@table =  Fabricate(:table)
	  Fabricate(:game_list)
    end

		it "should give the correct path" do
			link = link_to_game(@user, @table)
			link.should eq("/game/1")
		end
	end
end
