class BlackjackController < ApplicationController
  	
  	def lobby
  		@tables = Table.all 
  	end
end