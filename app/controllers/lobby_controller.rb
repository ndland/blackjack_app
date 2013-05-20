class LobbyController < ApplicationController
  	
  	def index
  		@tables = Table.all 
  		@user = current_user
		@game_list = GameList.find(params[:id])
  	end
end