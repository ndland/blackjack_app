class Api::UserController < ApplicationController
  FIELDS = ["id", "credits", "level", "name"]

  def show
    user = Person.find(params[:id])
    p "from user controller: user has #{user.credits}"

    render :json => user.to_json(:only => FIELDS)
  end
end
