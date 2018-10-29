class OrdersController < ApplicationController
  def index
    if current_user.role == 'registered_user'
      @user = current_user
      @orders = Order.where(user_id: @user.id)
      @heading = "Orders for #{@user.name}"
    else
      redirect_to login_path
    end
  end
  
  def show
    @order = Order.find(params[:id])
    @user = current_user
    
  def destroy
    order = Order.find(params[:id])
    order.cancel
    redirect_back(fallback_location: root_path)
  end
end
