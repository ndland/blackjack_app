class Api::BetController < ApplicationController

  attr_accessor :dealer

  def initialize
    @dealer = Dealer.new

  end

  def create
    2.times { dealer.deal_player_cards }

    user = current_user
    user.credits = (user.credits - params[:bet].to_i)
    user.save

    render :json => {}
  end
end
