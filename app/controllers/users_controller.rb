class UsersController < ApplicationController

	before_filter :login, except: [:create, :new]
	before_filter :find_user, except: [:new, :create, :index]
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
				respond_to do |format|
    				format.html { redirect_to users_path(@user) }
    				format.js
  				end
		else
			render 'new'
		end

	end

	def index
		redirect_to log_in_path and return unless session[:user_id]
		@users = User.all
	end

	def update
		if @user.update_attributes(params[:user])
			flash.notice = "Successfully updated profile."
			respond_to do |format|
    			format.html { redirect_to user_path(@user) }
   				format.js
  			end
		else
			flash.now.alert = "Can not update profile."
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
