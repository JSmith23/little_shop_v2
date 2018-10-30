class ItemsController < ApplicationController
	def index
			@items = Item.where(enabled: true)
	end

	def edit
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def show
		@item = Item.find(params[:id])
	end

	def create
		@item = Item.new(item_params)
		binding.pry
    if @item.save
      flash[:success] = "New item has been saved."
      redirect_to items_path
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
