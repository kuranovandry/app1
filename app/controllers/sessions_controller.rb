class SessionsController < ApplicationController
    skip_before_filter :login

    def new
        session[:user_id] = nil
        respond_to do |format|
            format.html
            format.js
        end
    end

    def create
        user = User.where(:email => params[:email]).first
        if user && User.authenticate(params[:email], params[:password])
            session[:user_id] = user.id
            redirect_to root_url, :notice => "Logged in!"
            respond_to do |format|
                format.html
                format.js
             end
        else
            flash.now.alert = "Invalid email or password"
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => "Logged out!"
    end

end