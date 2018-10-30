class SessionsController < ApplicationController
  def new
    if current_user
      flash[:notice] = "You are already logged in."
      redirect_to profile_path
    end
  end

  def create
    user = User.find_by_email(params[:email])
    if user.enabled && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in!"
      redirect_to profile_path
    else
      flash.now.alert = "Email or password is invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart] = nil
    flash[:notice] = "Logged out!"
    redirect_to root_path
  end
end
