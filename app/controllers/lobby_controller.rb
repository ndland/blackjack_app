class LobbyController < ApplicationController
  	
  	def index
  		@user = current_user
  		@tables = Table.all 
  	end
end
