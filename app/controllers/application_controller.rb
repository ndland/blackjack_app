class ApplicationController < ActionController::Base
  protect_from_forgery

 	def current_user
		
		return Person.find(1)
	end
end