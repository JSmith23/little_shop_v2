class ItemsController < ApplicationController
	def index
			@items = Item.where(enabled: true)
	end

	def edit
		@item = Item.find(params[:id])
	end

	def update
		if item_params[:thumbnail] == ""
			params[:item][:thumbnail] = "https://www.riobeauty.co.uk/images/product_image_not_found_thumb.gif"
		end
		@item = Item.find(params[:id])
    if Item.find(params[:id]).update(item_params)
      redirect_to dashboard_items_path
      flash[:notice] = "Update Successful!"
    else
      redirect_to edit_item_path(params[:id])
      flash[:notice] = "Update Unsuccessful."
    end
	end

	def destroy
		item = Item.find(params[:id])
		flash[:success] = "#{item.name} has been #{item.toggle_enabled}."
		if item.enabled? == false
			flash[:notice] = "This item is no longer for sale"
		else  
			flash[:notice] = "This item is now for sale"
		end
		redirect_back(fallback_location: root_path)
	end

	def new
		@item = Item.new
		@user = current_user
	end

	def show
		@item = Item.find(params[:id])
	end

	def create
		if item_params[:thumbnail] == ""
			params[:item][:thumbnail] = "https://www.riobeauty.co.uk/images/product_image_not_found_thumb.gif"
		end
		@item = Item.new(item_params.merge(user_id: current_user.id))
    if @item.save
      flash[:success] = "New item has been saved."
      redirect_to items_path
		elsif item_params[:price].to_i <= 0 || item_params[:inventory].to_i <= 0
			flash[:error] = "Price and inventory must be greater than 0.  Please try again."
			render :new
		else
      flash[:error] = "Something went wrong.  Please complete all required fields and try again."
      render :new
    end
	end

	private

  def item_params
    params.require(:item).permit( :name,
                                  :description,
                                  :price,
                                  :inventory,
                                  :thumbnail )
  end
end
