class Api::BetController < ApplicationController

  attr_accessor :dealer

  def initialize
    @dealer = Dealer.new

  end

  def create
    dealer.new_hand(params[:game_id].to_i)

    user = current_user
    user.credits = ( user.credits - params[:bet].to_i )
    user.save

    game = GameList.first(conditions: { id: params[:game_id].to_i})
    game.bet_amount = params[:bet].to_i
    game.save
    render :json => {}
  end

end
