require 'spec_helper'

describe LobbyController do

	describe "GET index" do
		it "should return the names of all of the entries" do
			table_1 = Fabricate(:table)
			table_2 = Fabricate(:table)
			table_3 = Fabricate(:table)
			
			get :index

			assigns(:tables).should eq([table_1, table_2, table_3])
		end
	end	

	describe "links on the lobby page" do

		it "should link to the beginner's table" do
			
			
		end		
	end
end