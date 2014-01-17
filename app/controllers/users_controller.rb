class UsersController < ApplicationController

	before_filter :login?, except: [:create, :new]
	before_filter :find_user, exept: [:new, :create, :index]
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

	def index
		if session[:user_id] != nil
			@users = User.all
		else
			redirect_to log_in_path
		end
	end

	def update
		if @user.update_attributes(params[:user])
			flash.now.alert = "Successfully updated profile."
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		@user.destroy
		redirect_to log_in_path
	end
	
	private
	
	def find_user
		@user = User.find(params[:id])
	end

end
