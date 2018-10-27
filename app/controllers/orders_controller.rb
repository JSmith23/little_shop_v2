class OrdersController < ApplicationController
  def index
    redirect_to login_path unless current_user
    if params[:id] && current_user.role == 'admin'
      @user = User.find(params[:id])
      @greeting = "Merchant order data for #{@user.name}"
    elsif current_user.role == 'merchant'
      @user = current_user
      @greeting = "Merchant Orders for #{@user.name}"
      @orders = Order.joins(:items).where(items: {user_id: current_user.id})
    else
      @user = current_user
      @orders = Order.where(user_id: current_user.id)
    end
	end
end
