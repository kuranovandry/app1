class UsersController < ApplicationController


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
			@user = User.all
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
		redirect_to users_path
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end
