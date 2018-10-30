class OrdersController < ApplicationController
  def index
    redirect_to login_path unless current_user
    if admin_user? && request_path == 'usersorders'
      @user = User.find(params[:user_id])
      @orders = Order.where(user_id: @user.id)
    elsif request_path == 'profileorders'
      @user = current_user
      @orders = @user.orders
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = current_user
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel
    redirect_to(profile_orders_path)
  end
end
