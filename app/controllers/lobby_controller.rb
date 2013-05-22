class LobbyController < ApplicationController
  	
  	def index
  		@tables = Table.all 
  		@user = current_user
	  	@game_list = GameList.first
  		# @forward_id= GameList.find(params[:id, :conditions => [:user_id => [2]]])
  	end
end
