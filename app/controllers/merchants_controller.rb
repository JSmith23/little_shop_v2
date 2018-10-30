class MerchantsController < ApplicationController
    def index
        if admin_user?
            @users = User.merchant.order(:name)
        else
            flash[:error] = "You are not authorized to view the requested page."
            redirect_to root_path
        end
    end

    def disable
        merchant.disable
        flash[:notice] = "Merchant '#{merchant.name}' is disabled!"
        redirect_to merchants_path
    end

    def enable
    end

    private

    def merchant
        id = params[:id] || params[:merchant_id]
        User.merchant.find(id)
    end
end
