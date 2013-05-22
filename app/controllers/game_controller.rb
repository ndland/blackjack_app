class GameController < ApplicationController
	
	def show
		@user = current_user
		@game_list = GameList.find(params[:id])
	end

	def create
		@game_list = GameList.new(params[:game_list])
		redirect_to @game_list
	end

	def index
		
	end
end