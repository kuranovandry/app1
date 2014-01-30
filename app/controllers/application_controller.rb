class ApplicationController < ActionController::Base
	protect_from_forgery

	include SessionsHelper
	before_filter :login

	def login
		redirect_to log_in_path unless current_user
	end

end