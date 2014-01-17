class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :login?
	helper_method :current_user

	def login?
		redirect_to log_in_path unless current_user
	end

	private

		def current_user
			@current_user ||= User.find(session[:user_id]) if session[:user_id]
			rescue ActiveRecord::RecordNotFound
		end

end