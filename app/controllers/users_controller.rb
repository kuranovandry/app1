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
		# @users = User.order("#{sort_column} #{sort_direction}").serch_by(params[:search])
    if params[:query].present?
      @users = User.order("#{sort_column} #{sort_direction}").search(params[:query])
      # @users.paginate(page: params[:page], per_page: 5)
      # @users = User.search(params[:query], page: params[:page])
    else
      @users = User.order("#{sort_column} #{sort_direction}").paginate(page: params[:page], per_page: 5)
    end
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
#     user = User.find(id)
#     user.update_attribute(:position, index) if user
      User.where(id: id).update_all({position: index+1})
      end
  render nothing: true
  end

  def autocomplete
    render json: User.search(params[:query], autocomplete: true).map(&:first_namer)
  end

  def live_search
      @users = User.find_latest params[:q]
      render :layout => false
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
