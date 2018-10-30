class DashboardController < ApplicationController

  def show
    redirect_to root_path unless merchant_user?
    if current_user.role == "merchant"
      @merchant = current_user
    else
    end
  end

end
