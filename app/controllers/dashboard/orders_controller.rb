class Dashboard::OrdersController < ApplicationController

  def index
    @orders = Order.merchant_orders(current_user.id)
  end

end
