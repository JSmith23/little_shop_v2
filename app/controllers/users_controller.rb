class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to profile_path(@user)
    else
      render :new
    end
  end
  
  def show
    redirect_to login_path unless current_user 
  end

  def edit
    redirect_to login_path unless current_user 
  end

  def update
    # Only accept password change if both fields are filled in
    if  params[:user][:password].blank? || 
        params[:user][:password_confirmation].blank?
    # Otherwise, remove both from params
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if current_user.update_attributes(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path
    elsif User.find_by(email: user_params[:email])
      flash[:error] = "An account is already registered with that email address."
      render :edit
    else
      flash[:error] = "No changes submitted."
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit( :name,
                                  :address,
                                  :city,
                                  :state,
                                  :zip,
                                  :email,
                                  :password,
                                  :password_confirmation )
  end
end