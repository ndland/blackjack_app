require 'spec_helper'

describe LobbyController do

	describe "GET index" do
		it "should return the names of all of the entries" do
			table_1 = Fabricate(:table)
			table_2 = Fabricate(:table)
			table_3 = Fabricate(:table)
			Fabricate(:person, id: 1)
			
			get :index

			assigns(:tables).should eq([table_1, table_2, table_3])
		end
	end

	describe "clicking beginners button" do			
		
	end			
end