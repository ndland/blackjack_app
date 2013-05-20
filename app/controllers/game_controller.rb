class GameController < ApplicationController
	
	def game
		@user = current_user
	end

	def show
		@game_list = GameList.find(params[:id])
	end

	def create
		@game_list = GameList.new(params[:game_list])
		redirect_to @game_list
	end
end