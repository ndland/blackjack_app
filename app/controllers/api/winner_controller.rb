class Api::WinnerController < ApplicationController

  def index
    winner = Winner.find(:first, conditions: {game_id: params[:game_id] })
    render :json => winner.to_json
  end
end
