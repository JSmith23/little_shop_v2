class UsersController < ApplicationController

  def index
    if current_user.role == 'admin'
      @users = User.order(:name)
    else
      flash[:error] = "You are not authorized to view the requested page."
      redirect_to root_path
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "You have successfully registered and are now logged in."
      redirect_to profile_path(@user)
    elsif User.find_by(email: user_params[:email])
      flash[:error] = "An account is already registered with that email address."
      render :new
    else
      flash[:error] = "Something went wrong.  Please complete all required fields and try again."
      render :new
    end
  end

  def show
    redirect_to login_path unless current_user
    if params[:id] && current_user.role == 'admin'
      @user = User.find(params[:id])
      @greeting = "Profile data for #{@user.name}"
    elsif current_user.role == 'merchant'
      @user = current_user
      @greeting = "Merchant Dashboard for #{@user.name}"
      @orders = @user.orders
      @items = @user.items
      render :dashboard
    else
      @user = current_user
      @greeting = "Welcome, #{@user.name}"
    end
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

  def destroy
    user = User.find(params[:id])
    user.toggle_enabled
    redirect_back(fallback_location: root_path)
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
