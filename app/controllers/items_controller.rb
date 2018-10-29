class ItemsController < ApplicationController
	def index
		if !current_user
			@items = Item.where(enabled: true)
		elsif current_user.role == 'merchant'
			@items = Item.where(user_id: current_user.id)
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

end
