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

  def patch
    @user = User.update(user_params)
    if @user.save
      redirect_to profile_path(@user)
    else
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