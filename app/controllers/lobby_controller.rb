class LobbyController < ApplicationController
  	
  	def index
  		@tables = Table.all 
  		@user = current_user
  	end
end