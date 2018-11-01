class Dashboard::ItemsController < ApplicationController

  def index
    if merchant_user?
      @user = current_user
    elsif admin_user?
      @user = User.find(params[:id])
    end
    @items = Item.where(user_id: @user.id)
  end
end
