class AutoComplateController < ApplicationController

  def index
        @users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:term]}%"])

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end
end
