class Api::BetController < ApplicationController

  def create
    user = current_user
    user.credits = (user.credits - params[:bet].to_i)
    user.save
    render :json => {}
  end
end
