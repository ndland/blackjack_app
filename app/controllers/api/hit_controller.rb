class Api::HitController < ApplicationController
  attr_accessor :dealer
  def initialize
    @dealer = Dealer.new
  end

  def create
    dealer.deal_player_card(params[:game_id])
    render :json => {}
  end
end
