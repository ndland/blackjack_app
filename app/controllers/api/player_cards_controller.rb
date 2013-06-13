class Api::PlayerCardsController < ApplicationController

  def index
    render json: {card1: "c"}
  end
end
