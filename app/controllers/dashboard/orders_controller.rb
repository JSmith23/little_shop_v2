class Dashboard::OrdersController < ApplicationController

  def index
    if merchant_user?
      @user = current_user
    elsif admin_user?
      @user = User.find(params[:id])
    end
    @orders = Order.merchant_orders(@user.id)
  end

end
