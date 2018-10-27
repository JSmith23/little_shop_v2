class CartsController < ApplicationController 
    include ActionView::Helpers::TextHelper
    def create 
        @item = Item.find(params[:item_id])
        session[:cart] ||= Hash.new(0)
        session[:cart][@item.id] ||= 0
        session[:cart][@item.id] = session[:cart][@item.id] += 1
        quantity = session[:cart][@item.id]
        flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{@item.name} in your cart."
        redirect_to items_path
    end 
end 