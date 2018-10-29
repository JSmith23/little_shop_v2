class ItemsController < ApplicationController
	def index
		if current_user && current_user.role == 'merchant'
			@user = current_user
			@items = Item.where(user_id: @user.id)
			@heading = "Merchant Items for #{@user.name}"
		else
			@items = Item.where(enabled: true)
		end
	end

	def edit
		@item = Item.find(params[:id])
	end

	def new
		@item = Item.new
	end

	def create

	end

	def show
		@item = Item.find(params[:id])
	end

end
