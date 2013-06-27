class Api::StandController < ApplicationController
  attr_accessor :dealer

  def initialize
    @dealer = Dealer.new
  end

  def create
    dealer.play(params[:game_id])
    render :json => {}
  end
end
