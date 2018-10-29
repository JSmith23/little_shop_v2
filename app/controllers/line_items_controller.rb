class LineItemsController < ApplicationController
    def destroy
        Cart.new(session[:cart]).remove_item(params[:id])
        redirect_to cart_path
    end

    def increment
        cart = Cart.new(session[:cart])

        if cart.can_increment_item?(params[:line_item_id])
            cart.increment_item(params[:line_item_id])
        else
            flash[:error] = "Exceed merchant inventory"
        end
        redirect_to cart_path
    end

    def decrement
        Cart.new(session[:cart]).decrement_item(params[:line_item_id])
        redirect_to cart_path
    end
end
