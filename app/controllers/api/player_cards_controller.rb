class Api::PlayerCardsController < ApplicationController
FIELDS = ["suit", "faceValue"]
  def index

    cards = PlayerCards.all
    render :json=> cards.to_json(:only => FIELDS)
  end
end
