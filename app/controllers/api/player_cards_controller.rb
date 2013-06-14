class Api::PlayerCardsController < ApplicationController

  def index
    render json: [{suit: "a", faceValue: "2"}, {suit: "b", faceValue: "Q"}]
  end
end
