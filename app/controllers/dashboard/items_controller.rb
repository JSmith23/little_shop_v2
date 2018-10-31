class Dashboard::ItemsController < ApplicationController

  def index
    if merchant_user?
      @items = Item.where(user_id: current_user.id)
    elsif admin_user?
      @items = Item.where(user_id: params[:id])
    end
  end
end
