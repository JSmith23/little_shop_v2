class OrdersController < ApplicationController
  def index
    if current_user.role == 'registered_user'
      @user = current_user
      @orders = Order.where(user_id: @user.id)
    elsif current_user.role == 'merchant'
      @user = current_user
      @greeting = "Merchant Orders for #{@user.name}"
      @orders = Order.joins(:items).where(items: {user_id: @user.id})
    else
      redirect_to login_path
    end
	end
end
