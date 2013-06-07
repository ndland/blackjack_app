class Api::BetController < ApplicationController

  def create
    user = current_user
    user.credits = (user.credits - params[:bet].to_i)
    user.save

    p "from bet controller: user has #{user.credits}"

    render :json => {}
  end
end
