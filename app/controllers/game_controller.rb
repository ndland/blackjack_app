class GameController < ApplicationController
	
	def game
	
	@user = current_user
	end
end