class UsersController < ApplicationController

before_filter :require_user, except: [:create, :new]

	def require_user
		redirect_to log_in_path unless current_user
	end

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash.now.alert = "Registration successful."
			redirect_to root_url
		else
			render 'new'
		end

	end

	def show
		@user = User.find(params[:id])
	end

	def index
		if session[:user_id] != nil
			@users = User.all
		else
			redirect_to log_in_path
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			flash[:notice] = "Successfully updated profile."
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to log_in_path
	end

end
