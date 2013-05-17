class LobbyController < ApplicationController
  	
  	def index
  		@tables = Table.all 
  	end
end