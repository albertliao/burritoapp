class SessionsController < ApplicationController
  def new
  end

  def create
  	@user = User.where(:email => params[:session][:email]).first
  	if @user && @user.authenticate(params[:session][:password])
  		flash[:success] = "Hello " + @user.name + ", you have logged in!"
  		cookies.permanent[:remember_token] = @user.id
  		@current_user = @user
  		redirect_to root_path
  	else
  		flash[:danger] = "Invalid email/password combination"
  		render 'new'
  	end
  end

  def destroy
  	cookies.permanent.delete(:remember_token)
  	redirect_to root_path
  end

end
