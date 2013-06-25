class Api::DealerCardsController < ApplicationController

  FIELDS = ["suit", "faceValue"]

  def index
    cards = DealerCards.find(:all, conditions: {game_id: params[:game_id]})
    render :json => cards.to_json(:only => FIELDS)
  end
end
