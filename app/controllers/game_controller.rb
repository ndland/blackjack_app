class GameController < ApplicationController

  def show
    @user = current_user
    @game_list = GameList.find(params[:id])
    @table = Table.find(:first, conditions: { id: @game_list.table_id })
  end

  def new
    @user = current_user
    @game_list = GameList.new(table_id:params[:table], user_id: @user.id)
    @game_list.save
    redirect_to game_path(@game_list)
  end

  def index

  end
end
