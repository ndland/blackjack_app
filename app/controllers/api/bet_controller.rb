class Api::BetController < ApplicationController

  attr_accessor :dealer

  def initialize
    @dealer = Dealer.new

  end

  def create
    2.times{
      dealer.deal_player_card(params[:game_id])
      dealer.deal_dealer_card(params[:game_id])
    }
    user = current_user
    user.credits = ( user.credits - params[:bet].to_i )
    user.save

    render :json => {}
  end
end
