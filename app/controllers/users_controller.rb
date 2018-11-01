class UsersController < ApplicationController

  def index
    if admin_user? && request_path == 'users'
      @users = User.order(:name)
      @heading = "All Users"
    elsif request_path == 'merchants'
      @users = User.where(role: 'merchant').order(:name)
      @heading = "All Merchants"
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
    if admin_user? && request_path == "users"
      @user = User.find(params[:id])
      redirect_to merchant_path(@user) unless @user.role == 'registered_user'
      @greeting = "Profile data for #{@user.name}"
      @edit_path = edit_user_path(@user)
      @orders_path = user_orders_path(user_id: @user.id)
      @role_path = upgrade_user_path(@user)
    elsif admin_user? && request_path == "profile"
      @user = current_user
      @greeting = "Profile data for #{@user.name}"
      @edit_path = profile_edit_path
      @orders_path = profile_orders_path
    elsif registered_user? || merchant_user?
      @user = current_user
      @greeting = "Welcome, #{@user.name}"
      @edit_path = profile_edit_path
      @orders_path = profile_orders_path
    end
    @orders = @user.orders
  end

  def edit
    redirect_to login_path unless current_user
    if params[:id] && admin_user?
      @user = User.find(params[:id])
    else
      @user = current_user
    end

  end

  def update
    self.remove_empty_password_from_params
    begin
      @user = User.find(params[:id])
      @user.update_attributes!(user_params)
    rescue ActiveRecord::RecordInvalid => e
      handle_update_exceptions(e)
    else
      self.redirect_after_successful_update
    end
  end

  def redirect_after_successful_update
    if admin_user? && @user.role == 'registered_user'
      flash[:success] = "Profile for #{@user.name} has been updated."
      redirect_to user_path(@user)
    elsif admin_user? && @user.role == 'merchant'
      flash[:success] = "Profile for #{@user.name} has been updated."
      redirect_to merchant_path(@user)
    else
      flash[:success] = "Your profile has been updated."
      redirect_to profile_path
    end
  end

  def destroy
    user = User.find(params[:id])
    flash[:success] = "#{user.name} has been #{user.toggle_enabled}."
    redirect_back(fallback_location: root_path)
  end

  def remove_empty_password_from_params
    # Only accept password change if both fields are filled in
    if  params[:user][:password].blank? ||
        params[:user][:password_confirmation].blank?
    # Otherwise, remove both from params
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end

  def handle_update_exceptions(error)
    if error.message == 'Validation failed: Email has already been taken'
      flash[:error] = "An account is already registered with that email address."
      render :edit
    else
      flash[:error] = "Update failed.  Please ensure all required fields are filled in and try again."
      render :edit
    end
  end

  def upgrade
    @user = User.find(params[:id])
    @user.upgrade_role
    flash[:success] = "User has been upgraded to merchant."
    redirect_to merchant_path(@user)
  end

  def downgrade
    @user = User.find(params[:id])
    @user.downgrade_role
    flash[:success] = "Merchant has been downgraded to registered user."
    redirect_to user_path(@user)
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
