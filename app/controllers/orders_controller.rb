class OrdersController < ApplicationController
  def index
    if current_user.role == 'registered_user'
      @user = current_user
      @orders = Order.where(user_id: @user.id)
      @heading = "Orders for #{@user.name}"
    elsif current_user.role == 'merchant'
      @user = current_user
      @orders = Order.joins(:items).where(items: {user_id: @user.id})
      @heading = "Merchant Orders for #{@user.name}"
    else
      redirect_to login_path
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel
    redirect_back(fallback_location: root_path)
  end
end
