class OrderItemsController < ApplicationController
  def update
    @order_item = OrderItem.find(params[:id])
    @item = Item.find(@order_item.item_id)
    @order = Order.find(@order_item.order_id)
    if @order_item.quantity > @item.inventory
      flash[:error] = "Order quantity exceeds inventory."
      redirect_back(fallback_location: root_path)
    else
      @item.reduce_inventory(@order_item.quantity)
      @order_item.fulfill
      flash[:success] = "Order item fulfilled."
      flash[:notice] = @order.update_status
      redirect_back(fallback_location: root_path)
    end
  end
end