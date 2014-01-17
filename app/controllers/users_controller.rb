class UsersController < ApplicationController

	before_filter :login?, except: [:create, :new]
	# has_many :questions, :dependent => :destroy
	# accepts_nested_attributes_for :questions
	
	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			session[:user_id] = @user.id
			flash.now.alert = "Registration successful."
			redirect_to users_path
		else
			render 'new'
		end

	end

	def show
		@user = User.find(params[:id])
	end

	def index
		redirect_to log_in_path and return unless session[:user_id]
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		if @user.update_attributes(params[:user])
			flash.now.alert = "Successfully updated profile."
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
