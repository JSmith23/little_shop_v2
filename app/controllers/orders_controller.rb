class OrdersController < ApplicationController
  def index
    redirect_to login_path unless current_user
    if admin_user? && request_path == 'usersorders'
      @user = User.find(params[:user_id])
      @orders = @user.orders
    elsif admin_user? && request_path == 'orders'
      @orders = Order.all
    elsif request_path == 'profileorders'
      @user = current_user
      @orders = @user.orders
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
    if merchant_user?
      @user = User.find(@order.user_id)
      @items = @order.items_for_merchant(current_user.id)
    else
      @user = current_user
      @items = @order.items.all
    end
  end

  def destroy
    order = Order.find(params[:id])
    order.cancel
    flash[:success] = "Order has been cancelled."
    redirect_back(fallback_location: root_path)
  end
end
