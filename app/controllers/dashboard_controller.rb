class DashboardController < ApplicationController

  def show
    if merchant_user?
      @merchant = current_user
    elsif admin_user? && request_path == 'merchants'
      @merchant = User.find(params[:id])
      redirect_to user_path(@merchant) unless @merchant.role == 'merchant'
      @role_path = downgrade_merchant_path(@merchant)
    elsif admin_user? && request_path == 'dashboard'
      @admin = current_user
    else
      redirect_to root_path 
    end
  end

end
