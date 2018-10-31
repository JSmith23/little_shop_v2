class OrdersController < ApplicationController
  def index
    redirect_to login_path unless current_user
    if admin_user? && request_path == 'usersorders'
      @user = User.find(params[:user_id])
      @orders = Order.where(user_id: @user.id)
      @heading = "All User Orders for #{@user.name}"
    elsif admin_user? && request_path == 'orders'
      @orders = Order.all
      @heading = "All Orders"
    elsif request_path == 'profileorders'
      @user = current_user
      @orders = @user.orders
      @heading = "All User Orders for #{@user.name}"
    end
  end

  def create
    @order = current_user.orders.create(status: "pending")
    cart = session[:cart]

    cart.each do |key, value|
      price = Item.find(key).price
      @order_item = @order.order_items.create(item_id: key, price: price, quantity: value)
    end
    session.delete(:cart)
    redirect_to profile_orders_path
  end

  def show
    @order = Order.find(params[:id])
    @user = current_user
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel
    redirect_back(fallback_location: root_path)
  end
end
