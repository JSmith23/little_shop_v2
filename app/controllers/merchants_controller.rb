class MerchantsController < ApplicationController
    def index
        return show_unauthorized_error_and_redirect unless admin_user?
        @users = User.merchant.order(:name)
    end

    def disable
        merchant.disable
        flash[:notice] = "Merchant '#{merchant.name}' is disabled!"
        redirect_to merchants_path
    end

    def edit
        return show_unauthorized_error_and_redirect unless admin_user?
    end

    # TODO: move dashboard path to /dashboard/:user_id or a like
    # and leave /merchants/:id for merchant show action
    # def show
    #     return show_unauthorized_error_and_redirect unless admin_user?
    # end

    private
    
    helper_method :merchant

    def merchant
        id = params[:id] || params[:merchant_id]
        User.merchant.find(id)
    end
end
