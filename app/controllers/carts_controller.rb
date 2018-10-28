class CartsController < ApplicationController 
    def index 

    end
     
    def create 
        item = Item.find(params[:item_id])
        @cart.add_item(item.id)
        session[:cart] = @cart.contents
        flash[:notice] = "You now have #{@cart.count_of(item.id)} #{item.name}."
        redirect_back(fallback_location: root_path)
    end 
end 

