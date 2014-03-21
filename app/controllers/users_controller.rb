class UsersController < ApplicationController

	before_filter :login, except: [:create, :new]
	before_filter :find_user, except: [:new, :create, :index, :sort, :autocomplete]
	helper_method :sort_column, :sort_direction
	
	def new
		@user = User.new
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
		else
			render 'new'
		end

	end

	def index
		redirect_to log_in_path and return unless session[:user_id]
    if params[:query].present?
      @users = User.paginate(page: params[:page], per_page: 5).order("#{sort_column} #{sort_direction}").search(params[:query])
    else
      @users = User.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
    end
	end

	def update
   render :edit unless @user.update_attributes(params[:user])
	end

	def destroy
		redirect_to session_path, notice: "You do not have permition to delete this user" and return  if current_user != @user
	end

  def sort
    params[:user].each_with_index do |id, index|
      User.where(id: id).update_all({position: index+1})
    end
    render nothing: true
  end
  
  def autocomplete
    # binding.pry
    render json: User.search(params[:query], autocomplete: true).map(&:full_name) if params[:query].size > 2
  end

private
	
	def find_user
		@user = User.find(params[:id])
	end

  def sort_column
    params[:sort].present? ? params[:sort] : "position"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

end
