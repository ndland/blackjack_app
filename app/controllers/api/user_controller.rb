class Api::UserController < ApplicationController
  FIELDS = ["id", "credits", "level", "name"]

  def show
    user = Person.find(params[:id])

    render :json => user.to_json(:only => FIELDS)
  end
end
