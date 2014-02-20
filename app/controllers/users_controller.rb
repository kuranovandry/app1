class UsersController < ApplicationController

	before_filter :login, except: [:create, :new]
	before_filter :find_user, except: [:new, :create, :index]
	# has_many :questions, :dependent => :destroy
	# accepts_nested_attributes_for :questions
	helper_method :sort_column, :sort_direction
	
	def new
		@user = User.new
		respond_to do |format|
			format.html
			format.js
		end
	end

	def edit
		respond_to do |format|
			format.html
			format.js 
		end
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
		@users = User.order("#{sort_column} #{sort_direction}").serch_by(params[:search])
	end

	def update
		if @user.update_attributes(params[:user])
			flash.notice = "Successfully updated profile."
			respond_to do |format|
    			format.html { redirect_to users_path }
   				format.js { redirect_to users_path }
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

	def sort
    params[:user].each_with_index do |id, index|
      User.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end
	
	private
	
	def find_user
		@user = User.find(params[:id])
	end

	def sort_column
    User.column_names.include?(params[:sort]) ? params[:sort] : "first_namer"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
