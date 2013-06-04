class Api::BetController < ApplicationController

  def create
    user= Person.find(params[:id])
    render :json => user.to_json
  end

  def index
    render json: ''
  end
end
