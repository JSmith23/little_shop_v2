class DashboardController < ApplicationController

  def show
    if merchant_user?
      @merchant = current_user
    elsif admin_user?
      @merchant = User.find(params[:id])
    else
      redirect_to root_path 
    end
  end

end
